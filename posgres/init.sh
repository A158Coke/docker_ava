#!/bin/bash

# 启动 PostgreSQL 服务
service postgresql start

# 修改 pg_hba.conf 文件以取消 peer 认证方式并允许密码认证
echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/14/main/pg_hba.conf
echo "listen_addresses='*'" >> /etc/postgresql/14/main/postgresql.conf

# 创建数据库和用户，并授予相应权限
sudo -u postgres psql -c "CREATE DATABASE my_db;"
sudo -u postgres psql -c "CREATE USER odoo WITH PASSWORD 'odoo';"
sudo -u postgres psql -c "ALTER USER odoo WITH SUPERUSER;"
sudo -u postgres psql -c "ALTER DATABASE my_db OWNER TO odoo;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE my_db TO odoo;"

# 在数据库中创建表
sudo -u postgres psql -d my_db -c "ALTER TABLE ir_module_module ADD COLUMN name VARCHAR(255), ADD COLUMN state VARCHAR(255);"


# 重新加载 PostgreSQL 配置
sudo -u postgres psql -c "SELECT pg_reload_conf();"

# 重启 PostgreSQL 服务
service postgresql restart

# 保持容器运行，以便查看日志
tail -f /dev/null
