########################################
# STAGE 1 – BUILD PYTHON (MUSL)
########################################
FROM alpine:3.19 AS builder

ENV PYTHON_VERSION=3.12.2

RUN apk add --no-cache \
    build-base \
    wget \
    musl-dev \
    libffi-dev \
    openssl-dev \
    zlib-dev \
    xz-dev \
    bzip2-dev \
    ncurses-dev \
    readline-dev \
    linux-headers \
    ca-certificates \
    sqlite-dev
WORKDIR /build

RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
 && tar -xzf Python-${PYTHON_VERSION}.tgz

WORKDIR /build/Python-${PYTHON_VERSION}

RUN ./configure \
    --enable-optimizations \
    --disable-shared \
 && make -j$(nproc) \
 && make install

# ---- Prepare app with correct ownership ----
WORKDIR /app

# Ensure pip is available
RUN python3 -m ensurepip

# Install Python packages (Django + requirements)

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

COPY . /app/

# Pre-create logs directory
RUN mkdir -p /app/logs \
 && chmod 755 /app/logs
RUN mkdir -p /tmp && chmod 1777 /tmp
########################################
# STAGE 2 – FINAL RUNTIME (SCRATCH)
########################################
FROM scratch

# ---- Python runtime ----
COPY --from=builder /usr/local /usr/local

# ---- musl loader + libs ----
COPY --from=builder /lib/ld-musl-*.so.1 /lib/
COPY --from=builder /usr/lib/libssl.so* /usr/lib/
COPY --from=builder /usr/lib/libcrypto.so* /usr/lib/
COPY --from=builder /lib/libz.so* /lib/
COPY --from=builder /usr/lib/libffi.so* /usr/lib/
COPY --from=builder /usr/lib/libsqlite3.so* /usr/lib/
# ---- App (already prepared) ----
WORKDIR /app
COPY --from=builder /app /app
COPY --from=builder /tmp /tmp
COPY entrypoint.py /entrypoint.py

# ---- Python runtime env ----
ENV PYTHONHOME=/usr/local \
    PYTHONPATH=/usr/local/lib/python3.11 \
    PATH=/usr/local/bin \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

ENTRYPOINT ["/usr/local/bin/python3", "/entrypoint.py"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]

EXPOSE 8000
