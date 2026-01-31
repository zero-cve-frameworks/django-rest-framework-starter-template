"""
API URL Configuration

This file organizes all API endpoints.
Import views from other apps and expose them here.
"""

from django.urls import path
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

from apps.base.views import HealthCheckAPIView

app_name = "api"

urlpatterns = [
    # Example: Health check endpoint from base app
    path("health/", HealthCheckAPIView.as_view(), name="health"),
    # JWT Token endpoints
    path("token/", TokenObtainPairView.as_view(), name="token_obtain_pair"),
    path("token/refresh/", TokenRefreshView.as_view(), name="token_refresh"),
]
