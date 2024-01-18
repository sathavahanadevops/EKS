FROM nginx:1.10.1-alpine
COPY index.html /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]



=====================
install vi tools inside docker container

apt-get update
apt-get install vim -y
