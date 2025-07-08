set shell := ["sh", "-c"]

[private]
default:
  @just -l

# Docker compose commands ------------------------------------------------------
compose := "docker compose -f compose.yml"
compose_run := compose + " run --rm"
compose_exec := compose + " exec"

manage_db := compose_run + " database"


# Odoo management --------------------------------------------------------------
# [NOT IMPLEMENTED] Download Odoo addons as git submodules
[group("Odoo management")]
get-modules:
  @echo "{{ style('warning') }}Not implemented{{ NORMAL }}"
  @echo "This function is not implemented yet."

# Install Odoo addons
[group("Odoo management")]
install-modules:
  sh ./scripts/copy_addons.sh

# Dev environment --------------------------------------------------------------
# Copy all the required files to develop. WARNING: Overwrites all the config files.
[group("Dev environment")]
configure:
  cp .template.env .env

# [NOT IMPLEMENTED] Bootstraps the project for developing
[group("Dev environment")]
bootstrap:
  @echo "{{ style('warning') }}Not implemented{{ NORMAL }}"
  @echo "This function is not implemented yet."

# [NOT IMPLEMENTED] Uninstall and re-run the project bootstrap
[group("Dev environment")]
bootstrap-refresh:
  @echo "{{ style('warning') }}Not implemented{{ NORMAL }}"
  @echo "This function is not implemented yet."


# Services management ----------------------------------------------------------
# Manage services for the app
[group("Dev environment")]
[group("Service management")]
services-up *args="-d":
  {{compose}} up {{ args }}

# Show services logs
[group("Dev environment")]
[group("Service management")]
services-logs service="" *args="-f":
  {{compose}} logs {{args}} {{service}}

# Shut down services
[group("Dev environment")]
[group("Service management")]
services-down *args="--remove-orphans":
  {{compose}} down {{ args }}

# Restart services
[group("Dev environment")]
[group("Service management")]
services-restart: services-down services-up

# Launch shell insto the services container. Launch into Odoo by default.
[group("Dev environment")]
[group("Service management")]
services-shell service="web" *args="":
  {{compose_exec}} {{ args }} {{ service }} bash

# Database management ----------------------------------------------------------
# # Create migration
# [group("Database Management")]
# makemigration migration_name +options="--autogenerate":
#   {{migrations_manager}} revision {{ options }} -m {{ migration_name }}
#
# # Apply migrations
# [group("Database Management")]
# migrate:
#   {{migrations_manager}} upgrade head
#
# # Backup database
# [group("Database Management")]
# backup:
#   {{manage_db}} /admin/bin/backup.sh
#
# # List available database backups
# [group("Database Management")]
# list-backups:
#   {{manage_db}} /admin/bin/list_backups.sh
#
# # Restore database from file named 'backup_filename'.
# [group("Database Management")]
# restore backup_filename:
#   {{manage_db}} /admin/bin/restore.sh {{backup_filename}}
#   just services-up

# Stops all services and deletes the database volume
[group("Database Management")]
db-destroy:
  just services-down
  docker volume rm odoo-localdev_odoo-web-data
  docker volume rm odoo-localdev_postgres-data

# Destroy database and rerun migrations
[group("Dev environment")]
[group("Database Management")]
db-reset: db-destroy
