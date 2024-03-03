#!/bin/bash

# 启动Odoo服务并放到后台运行
python3 odoo /odoo/odoo-bin -r odoo -w odoo --addons-path=addons -i base -d my_db --db_port 5432 -c /odoo/odoo.conf

# 保持容器运行状态
tail -f /dev/null
