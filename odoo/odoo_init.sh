#!/bin/bash
python3 /odoo/odoo-bin -r odoo -w odoo --addons-path=addons -i base -d my_db --db_port 5432 -c /odoo/odoo.conf &
tail -f /dev/null
