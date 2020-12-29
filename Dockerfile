FROM nginx

ENV SERVER_PORT=80
ENV INDEX_FILE='index.php'
ENV ERR_LOG_PATH='/var/log/nginx/error.log'
ENV ACC_LOG_PATH='/var/log/nginx/access.log'
ENV DOCUMENT_ROOT='/var/www/public'
ENV FPM_CONTAINER_NAME='php-fpm'
ENV FPM_CONTAINER_PORT=9000

# Copy config file
COPY nginx.conf /etc/nginx/conf.d/
RUN rm /etc/nginx/conf.d/default.conf
RUN mv /etc/nginx/conf.d/nginx.conf /etc/nginx/conf.d/default.conf

# Replace parameters
RUN sed -i 's:{server_port}:'"$SERVER_PORT"':' /etc/nginx/conf.d/default.conf
RUN sed -i 's:{index_file}:'"$INDEX_FILE"':' /etc/nginx/conf.d/default.conf
RUN sed -i 's:{error_log_path}:'"$ERR_LOG_PATH"':' /etc/nginx/conf.d/default.conf
RUN sed -i 's:{acess_log_path}:'"$ACC_LOG_PATH"':' /etc/nginx/conf.d/default.conf
RUN sed -i 's:{document_root}:'"$DOCUMENT_ROOT"':' /etc/nginx/conf.d/default.conf
RUN sed -i 's:{contianer_name}:'"$FPM_CONTAINER_NAME"':' /etc/nginx/conf.d/default.conf
RUN sed -i 's:{fpm_port}:'"$FPM_CONTAINER_PORT"':' /etc/nginx/conf.d/default.conf
