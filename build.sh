# This script is used for deploying the application on Vercel.
# Note: Dependencies are automatically installed by Vercel from requirements.txt

echo "Collecting static files..."
python manage.py collectstatic --no-input
