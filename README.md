## FPM Nginx
A basic nginx php-fpm proxy image not requiring a copy of the app files.

This is the repository for the [`vladerc/fpm-nginx`](https://hub.docker.com/repository/docker/vladerc/fpm-nginx) Docker image.

### Available ENV Parameters
| Name | Default value |
| ---- | ---- |
| SERVER_PORT | 80 |
| INDEX_FILE | index.php |
| ERR_LOG_PATH | /var/log/nginx/error.log |
| ACC_LOG_PATH | /var/log/nginx/access.log |
| DOCUMENT_ROOT | /var/www/public |
| FPM_CONTAINER_NAME | php-fpm |
| FPM_CONTAINER_PORT | 9000 |

### Build command

`docker build --platform linux/amd64,linux/arm64 . -t vladerc/fpm-nginx:latest -t vladerc/fpm-nginx:v1.0` - Replace `v1.0` with latest tag.

`docker push vladerc/fpm-nginx --all-tags` - Push all local tags to remote repository.