#!/bin/bash

# Reset config
cp /etc/nginx/conf.d/nginx_conf_template /etc/nginx/conf.d/default.conf

# Replace parameters
sed -i 's:\[server_port\]:'"$SERVER_PORT"':g' /etc/nginx/conf.d/default.conf
sed -i 's:\[index_file\]:'"$INDEX_FILE"':g' /etc/nginx/conf.d/default.conf
sed -i 's:\[error_log_path\]:'"$ERR_LOG_PATH"':g' /etc/nginx/conf.d/default.conf
sed -i 's:\[access_log_path\]:'"$ACC_LOG_PATH"':g' /etc/nginx/conf.d/default.conf
sed -i 's:\[document_root\]:'"$DOCUMENT_ROOT"':g' /etc/nginx/conf.d/default.conf
sed -i 's:\[container_name\]:'"$FPM_CONTAINER_NAME"':g' /etc/nginx/conf.d/default.conf
sed -i 's:\[fpm_port\]:'"$FPM_CONTAINER_PORT"':g' /etc/nginx/conf.d/default.conf

# Execute CMD statement
exec "$@"