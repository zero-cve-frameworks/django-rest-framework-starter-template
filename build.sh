# This script is used for deploying the application on Vercel.
# Note: Dependencies are automatically installed by Vercel from requirements.txt

echo "Migrating Database..."
python manage.py makemigrations
python manage.py migrate

echo "Collecting static files..."
python manage.py collectstatic --no-input
