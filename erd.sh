#!/bin/bash
# Generate Entity Relationship Diagram for all models

python manage.py graph_models -a -g -o docs/design/images/models.jpg
