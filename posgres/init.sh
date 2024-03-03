#!/bin/bash
service postgresql start
echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/14/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/14/main/postgresql.conf

# Crea base de datos y usuarios y dar usuario el perimiso
sudo -u postgres psql -c "CREATE DATABASE my_db;"
sudo -u postgres psql -c "CREATE USER odoo WITH PASSWORD 'odoo';"
sudo -u postgres psql -c "ALTER USER odoo WITH SUPERUSER;"
sudo -u postgres psql -c "ALTER DATABASE my_db OWNER TO odoo;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE my_db TO odoo;"

sudo -u postgres psql -c "SELECT pg_reload_conf();"
service postgresql restart

# Mantenga el container running en el bacl
tail -f /dev/null
