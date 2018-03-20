FROM node:8-alpine

ARG SOURCE_FOLDER="./"
WORKDIR "/server"

# Copy the source file
COPY ${SOURCE_FOLDER} .

# Install dependencies
RUN npm i

# Start the express server
ENTRYPOINT ["node", "app"]

EXPOSE 5000