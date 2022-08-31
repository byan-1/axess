"""
Django command to wait for database to be available.
"""
import time
from psycopg2 import OperationalError as Psycopg2Error
from django.db.utils import OperationalError
from datetime import datetime
from django.core.management.base import BaseCommand


class Command(BaseCommand):
    """Django command to wait for database to be available."""

    def handle(self, *args, **options):
        """Entrypoint for command"""
        self.stdout.write("Waiting for database...")
        db_up = False
        start_time = datetime.now()
        while db_up is False:
            try:
                self.check(databases=["default"])
                db_up = True
            except (Psycopg2Error, OperationalError):
                self.stdout.write("Database unavailable, waiting 1 second...")
                time.sleep(1)
            time_delta = datetime.now() - start_time
            if time_delta.seconds >= 10:
                raise Exception("Database connection timed out...")
        self.stdout.write(self.style.SUCCESS("Database available!"))
