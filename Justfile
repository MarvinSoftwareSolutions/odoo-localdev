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
# [group("Odoo management")]
# [NOT IMPLEMENTED] Download Odoo addons as git submodules
get-modules:
  @echo "Not implemented"
  @echo "This function is not implemented yet."

# [group("Odoo management")]
# Install Odoo addons
install-modules:
  sh ./scripts/copy_addons.sh

# Dev environment --------------------------------------------------------------
# [group("Dev environment")]
# Copy the required config files. WARNING: Overwrites existing config files.
[confirm]
configure:
  cp .template.env .env

# [group("Dev environment")]
# [NOT IMPLEMENTED] Bootstraps the project for developing
bootstrap:
  @echo "Not implemented"
  @echo "This function is not implemented yet."

# [group("Dev environment")]
# [NOT IMPLEMENTED] Uninstall and re-run the project bootstrap
bootstrap-refresh:
  @echo "Not implemented"
  @echo "This function is not implemented yet."


# Services management ----------------------------------------------------------
# [group("Dev environment")]
# [group("Service management")]
# Manage services for the app
services-up *args="-d":
  {{compose}} up {{ args }}

# [group("Dev environment")]
# [group("Service management")]
# Show services logs
services-logs service="" *args="-f":
  {{compose}} logs {{args}} {{service}}

# [group("Dev environment")]
# [group("Service management")]
# Shut down services
services-down *args="--remove-orphans":
  {{compose}} down {{ args }}

# [group("Dev environment")]
# [group("Service management")]
# Restart services
services-restart: services-down services-up

# [group("Dev environment")]
# [group("Service management")]
# Launch shell insto the services container. Launch into Odoo by default.
services-shell service="web" *args="":
  {{compose_exec}} {{ args }} {{ service }} bash

# # Database management ----------------------------------------------------------
# [group("Database Management")]
# # Create migration
# makemigration migration_name +options="--autogenerate":
#   {{migrations_manager}} revision {{ options }} -m {{ migration_name }}
#
# [group("Database Management")]
# # Apply migrations
# migrate:
#   {{migrations_manager}} upgrade head
#
# [group("Database Management")]
# # Backup database
# backup:
#   {{manage_db}} /admin/bin/backup.sh
#
# [group("Database Management")]
# # List available database backups
# list-backups:
#   {{manage_db}} /admin/bin/list_backups.sh
#
# [group("Database Management")]
# # Restore database from file named 'backup_filename'.
# restore backup_filename:
#   {{manage_db}} /admin/bin/restore.sh {{backup_filename}}
#   just services-up

# [group("Database Management")]
# Stops all services and deletes the database volume
[confirm]
db-destroy:
  just services-down
  docker volume rm odoo-localdev_odoo-web-data
  docker volume rm odoo-localdev_postgres-data

# [group("Dev environment")]
# [group("Database Management")]
# # Destroy and reconfigure the database
# db-reset: db-destroy
