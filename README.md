# Django REST Framework Starter Template

A production-ready Django REST Framework starter template with JWT authentication, CORS configuration, API documentation, and environment-based settings.

## Features

- **Django REST Framework** with JWT authentication
- **CORS** configured for frontend communication
- **API Documentation** with Swagger/ReDoc (drf-yasg)
- **Environment-based configuration** (Development/Production)
- **Database** support (SQLite for dev, PostgreSQL/MySQL via DATABASE_URL for production)
- **Security headers** and best practices
- **Structured app organization** with `apps/` directory

## Quick Start

See [docs/steps/README.md](docs/steps/README.md) for detailed setup instructions.

## Project Structure

```
├── apps/
│   └── base/              # Base app
├── core/                  # Django project settings
├── manage.py
├── requirements.txt
└── .env.template
```

## Configuration

The project uses environment variables for configuration. Copy `.env.template` to `.env` and update the values:

- `SECRET_KEY`: Django secret key
- `ENVIRONMENT`: `DEV` or `PROD`
- `DATABASE_URL`: Database connection string (for production)
- `FRONTEND_URL`: Frontend URL for CORS

## API Documentation

When running in DEBUG mode, access API documentation at:
- Swagger UI: `/swagger/`
- ReDoc: `/redoc/`
