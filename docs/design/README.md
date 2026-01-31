# Design Documentation

## Entity Relationship Diagram (ERD)

Generate an ERD diagram of all models:

```bash
./erd.sh
```

This will create `images/models.jpg` showing the database schema and relationships.

**Requirements:**
- django-extensions
- pydotplus
- Graphviz (system dependency)

**Install Graphviz:**
- macOS: `brew install graphviz`
- Ubuntu/Debian: `sudo apt-get install graphviz`
- Windows: Download from [Graphviz website](https://graphviz.org/download/)
