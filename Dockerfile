FROM nginx:alpine
ARG HOSTNAME=example.com
RUN apk add --no-cache git openssl
RUN git clone https://github.com/cgosec/Blauhaunt
RUN cp -r Blauhaunt/app/* /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt \
    -subj "/C=US/ST=State/L=City/O=Organization/OU=Unit/CN=${HOSTNAME}"
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
