# Pull from Base Image
FROM node:18.12.1-bullseye-slim

# Install/Update Node.js and Node Package Manager
RUN apt-get update && \
    apt-get install -y nodejs npm

# Create and set app working directory
WORKDIR /app

# Copy files and npm install
COPY src/backend/. .
RUN npm i

# Twindle the permissions to ensure things can be run as an arbitary user
RUN chown -R 1001:0 /app && \
    chmod -R ug+rwx /app

# Provide access to node for adding logs
RUN mkdir -p /.npm && chown -R 1001:0 /.npm && chmod -R ug+rwx /.npm

# Create and set user
USER 1001

# Entrypoint
CMD ["npm", "run", "start"]
