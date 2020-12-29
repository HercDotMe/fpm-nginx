FROM nginx

ENV SERVER_PORT=80
ENV INDEX_FILE='index.php'
ENV ERR_LOG_PATH='/var/log/nginx/error.log'
ENV ACC_LOG_PATH='/var/log/nginx/access.log'
ENV DOCUMENT_ROOT='/var/www/public'
ENV FPM_CONTAINER_NAME='php-fpm'
ENV FPM_CONTAINER_PORT=9000

# Copy config file
COPY nginx.conf /etc/nginx/conf.d/nginx_conf_template

# Copy entry file
WORKDIR /etc/nginx
COPY entrypoint.sh ./entrypoint.sh
RUN ["chmod", "+x", "./entrypoint.sh"]

# Expose port
EXPOSE ${SERVER_PORT}

ENTRYPOINT ["./entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
