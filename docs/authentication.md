# JWT Authentication

This project uses JWT (JSON Web Tokens) for API authentication via `djangorestframework-simplejwt`.

## Overview

JWT authentication is configured and ready to use. The system uses Django's default User model, so no custom user app is required.

## Token Endpoints

### 1. Obtain Tokens (Login)

**Endpoint:** `POST /api/token/`

**Request:**
```json
{
  "username": "your_username",
  "password": "your_password"
}
```

**Response:**
```json
{
  "access": "eyJ0eXAiOiJKV1QiLCJhbGc...",
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

**Example with curl:**
```bash
curl -X POST http://localhost:8000/api/token/ \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "your_password"}'
```

### 2. Refresh Access Token

**Endpoint:** `POST /api/token/refresh/`

**Request:**
```json
{
  "refresh": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

**Response:**
```json
{
  "access": "eyJ0eXAiOiJKV1QiLCJhbGc..."
}
```

**Example with curl:**
```bash
curl -X POST http://localhost:8000/api/token/refresh/ \
  -H "Content-Type: application/json" \
  -d '{"refresh": "your_refresh_token"}'
```

## Using Tokens in API Requests

Include the access token in the `Authorization` header:

```
Authorization: Bearer <your_access_token>
```

**Example with curl:**
```bash
curl -X GET http://localhost:8000/api/your-endpoint/ \
  -H "Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGc..."
```

## Configuration

Token settings are configured in `core/settings.py`:

```python
SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(days=30),
}
```

- **Access Token Lifetime:** 30 days
- **Refresh Token:** Used to obtain new access tokens
- **User Model:** Django's default User model (no custom user app needed)

## Creating a User

Before obtaining tokens, create a superuser:

```bash
python manage.py createsuperuser
```

Or create a regular user via Django admin or programmatically.

## Testing Authentication

1. **Create a user** (if you haven't already):
   ```bash
   python manage.py createsuperuser
   ```

2. **Obtain tokens:**
   ```bash
   curl -X POST http://localhost:8000/api/token/ \
     -H "Content-Type: application/json" \
     -d '{"username": "admin", "password": "your_password"}'
   ```

3. **Use the access token** in protected endpoints:
   ```bash
   curl -X GET http://localhost:8000/api/protected-endpoint/ \
     -H "Authorization: Bearer <your_access_token>"
   ```

## API Documentation

The token endpoints are automatically documented in:
- **Swagger UI:** http://localhost:8000/swagger/
- **ReDoc:** http://localhost:8000/redoc/

(Only available in DEBUG mode)

### Using Swagger UI with JWT Authentication

1. **Get your access token** from `/api/token/` endpoint in Swagger UI
2. **Click the "Authorize" button** (lock icon) at the top right of Swagger UI
3. **In the "Bearer" field**, enter your token **with the "Bearer " prefix**:
   ```
   Bearer eyJ0eXAiOiJKV1Q...
   ```
   **Important:** You must include the word "Bearer " followed by a space before your token.
4. **Click "Authorize"** and then "Close"
5. The token will persist across page refreshes (thanks to `PERSIST_AUTH` setting)
6. Now you can test protected endpoints - they will automatically include the `Authorization: Bearer <token>` header

**Example:**
- ✅ Correct: `Bearer eyJ0eXAiOiJKV1Q...`
- ❌ Wrong: `eyJ0eXAiOiJKV1Q...` (missing "Bearer " prefix)

## Notes

- Tokens are stateless - no database lookups required for validation
- Access tokens expire after 30 days (configurable)
- Use refresh tokens to obtain new access tokens without re-authenticating
- Django admin uses session authentication (separate from JWT)
- All API endpoints require authentication by default (unless `permission_classes = []` is set)
