# Steps

## Project Setup

### 1. Create Django Project

```bash
django-admin startproject core .
```

### 2. Create Base App

```bash
python manage.py startapp base
```

### 3. Move App to `apps` Directory

```bash
mkdir -p apps
mv base apps/base
```

### 4. Update App Configuration

Update `apps/base/apps.py`:

```python
from django.apps import AppConfig

class BaseConfig(AppConfig):
    default_auto_field = 'django.db.models.BigAutoField'
    name = 'apps.base'
```

**Note**: `core/settings.py` has been configured with REST Framework (JWT authentication, CORS), database (environment-based with dj-database-url), static files, media files, security headers, and logging.

### 5. Install Dependencies

```bash
pip install -r requirements.txt
```

Required packages:
- Django
- djangorestframework
- python-decouple
- drf-yasg
- djangorestframework-simplejwt
- django-cors-headers
- dj-database-url
- black (code formatting)
- isort (import sorting)
- pre-commit (git hooks)

### 6. Setup Pre-commit Hooks (Recommended)

Pre-commit hooks automatically format code and check for issues before commits:

```bash
# Install pre-commit hooks
pre-commit install

# (Optional) Run on all files once to format existing code
pre-commit run --all-files
```

The hooks will:
- Format code with black (120 character line length)
- Sort imports with isort (black-compatible)
- Check for trailing whitespace, file endings, and other issues

**Note**: If you need to bypass hooks (not recommended), use `git commit --no-verify`

### 7. Environment Configuration

Create `.env` file from `.env.template`:

```bash
cp .env.template .env
```

Update `.env` with your configuration:
- `SECRET_KEY`: Generate a Django secret key
- `DATABASE_URL`: For production (optional in development, uses SQLite by default)
- `FRONTEND_URL`: Your frontend URL (default: http://localhost:3000)
- `ENVIRONMENT`: Set to `DEV` for development or `PROD` for production

### 8. Database Setup

Run migrations:

```bash
python manage.py makemigrations
python manage.py migrate
```

### 9. Create Superuser (Optional)

```bash
python manage.py createsuperuser
```

### 10. Run Development Server

```bash
python manage.py runserver
```

## Project Structure

```
jobrio-backend/
├── apps/
│   ├── __init__.py
│   └── base/              # Base app (renamed from scrapers)
│       ├── __init__.py
│       ├── admin.py
│       ├── apps.py
│       ├── models.py
│       ├── views.py
│       └── migrations/
├── core/                   # Django project settings
│   ├── __init__.py
│   ├── settings.py
│   ├── urls.py
│   ├── views.py           # Schema view for API docs
│   ├── constants.py       # Environment constants
│   ├── wsgi.py
│   └── asgi.py
├── manage.py
├── requirements.txt
├── .env.template
└── README.md
```

## API Documentation

Once the server is running, access API documentation:

- **Swagger UI**: http://localhost:8000/swagger/
- **ReDoc**: http://localhost:8000/redoc/

(Only available in DEBUG mode)

## Configuration Highlights

### REST Framework
- JWT Authentication configured
- CORS enabled for frontend communication
- API documentation with drf-yasg

### Database
- Development: SQLite (default)
- Production: Configure via `DATABASE_URL` environment variable

### Security
- Environment-based security settings
- CORS configured for frontend origin
- HSTS and security headers enabled in production

### Code Quality
- Black code formatter (120 character line length)
- isort import sorter (black-compatible)
- Pre-commit hooks to enforce formatting automatically
