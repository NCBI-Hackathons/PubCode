FROM nginx

# Set the source folder
ARG SOURCE_FOLDER="./"

# Create app directory
WORKDIR /var/www/app

RUN rm /etc/nginx/conf.d/default.conf

# Install app dependencies
COPY app-nginx.conf /etc/nginx/conf.d

# Bundle app source
COPY ${SOURCE_FOLDER} .

EXPOSE 8000
