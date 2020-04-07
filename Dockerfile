FROM alpine:3.9.3

RUN addgroup www -S && \
    adduser www -G www -S && \
    apk update && \
    apk add p7zip nginx jq wget curl --no-cache && \
    rm -rf /var/cache/apk/* && mkdir /www && \
    chown -R www:www /var/lib/nginx && \
    chown -R www:www /www && \
    mkdir -p /run/nginx && \
    chown -R www:www /run/nginx && \
    rm -rf /var/cache/apk/* && \
    wget --quiet $(curl -s https://api.github.com/repos/gchq/CyberChef/releases/latest | jq -r ".assets[] | select(.name) | .browser_download_url" | grep zip) -O /tmp/chef.zip && \
    unzip /tmp/chef.zip -d /www && \
    mv /www/CyberChef_v*.html /www/index.html

COPY ./resources/nginx.conf /etc/nginx/nginx.conf

USER www
EXPOSE 8000
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]
