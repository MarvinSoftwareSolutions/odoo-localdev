# Odoo LocalDev

![GitHub License](https://img.shields.io/badge/License-MIT-green)

This repository is used for local Odoo module development. It's heavily
inspired in the [SolTec localdev
project](https://github.com/Mueve-TEC/soltec-localdev).

> [!CAUTION]
> **DO NOT USE THIS IN PRODUCTION**
>
> This project is used only for Odoo modules development purposses.


## Dependencies

- [Justfile >= 1.40.0](https://github.com/casey/just)
- [Docker](https://www.docker.com/products/docker-desktop)
- Rsync

If you prefer you can create a virtualenv, activate it and install Just in
there. If you use UV these are the required steps:

- `uv venv`
- `source .venv/bin/activate`
- `uv pip install -r requirements.txt`


## Usage instructions

- Start all services using `just services-up`.
- Stop all services using `just services-down`.
- Restart all services using `just services-restart`.

- Default port and URL: [https://odoo.localhost/](https://odoo.localhost/).
Accept the self signed ssl cert.

### Download an install custom modules

Go into the [./submodules/](/submodules/) directory and clone the Odoo custom
modules you want to develop using `git submodule add -f
<git-odoo-module-repository>`.

Install the modules to be detected by Odoo using `just install-modules`, go
into Odoo, **enable developer mode**, go to the Applications section and
refresh the applications list. Now you should be able to see the modules to
install.
