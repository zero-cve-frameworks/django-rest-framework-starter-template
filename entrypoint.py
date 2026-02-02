#!/usr/bin/env python3
import os
import sys
import subprocess


APP_DIR = "/app"
MANAGE_PY = os.path.join(APP_DIR, "manage.py")


def run_manage_command(command: str):
    print(f"Running: manage.py {command}")

    subprocess.run(
        [sys.executable, MANAGE_PY] + command.split(),
        check=False,
        cwd=APP_DIR,
    )


def main():
    # Always operate from /app
    os.chdir(APP_DIR)

    # Ensure logs directory
    logs_dir = os.path.join(APP_DIR, "logs")
    if not os.path.exists(logs_dir):
        print("Creating logs directory...")
        os.makedirs(logs_dir, exist_ok=True)

    # Optional Django management tasks
    if os.environ.get("RUN_MANAGE_TASKS") == "1":
        run_manage_command("collectstatic --noinput")
        run_manage_command("migrate")

    # Execute runtime command
    if len(sys.argv) > 1:
        print(f"Executing: {' '.join(sys.argv[1:])}")
        os.execv(
            sys.executable,
            [sys.executable] + sys.argv[1:],
        )
    else:
        print("Starting Django development server...")
        os.execv(
            sys.executable,
            [sys.executable, MANAGE_PY, "runserver", "0.0.0.0:8000"],
        )


if __name__ == "__main__":
    main()
