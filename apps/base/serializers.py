from rest_framework import serializers


class HealthCheckSerializer(serializers.Serializer):
    """Simple serializer for health check endpoint."""

    status = serializers.CharField(read_only=True)
    message = serializers.CharField(read_only=True)
    version = serializers.CharField(read_only=True)


class ProtectedDataSerializer(serializers.Serializer):
    """Serializer for protected endpoint response."""

    message = serializers.CharField(read_only=True)
    user_id = serializers.IntegerField(read_only=True)
    username = serializers.CharField(read_only=True)
    is_authenticated = serializers.BooleanField(read_only=True)
