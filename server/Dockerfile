FROM node:8-stretch

ARG SOURCE_FOLDER="./"
WORKDIR "/server"

# Copy the source file
COPY ${SOURCE_FOLDER} .

# Add entrypoint script to init db
ADD entrypoint.sh /usr/local/bin/
RUN chmod 700 /usr/local/bin/entrypoint.sh

# Install dependencies
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install postgresql
RUN npm i

# Start the express server
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 5000