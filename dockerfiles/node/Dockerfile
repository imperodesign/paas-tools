# Set the base image to the official Node.js one
FROM node:4.2.4

# File Author / Maintainer
MAINTAINER Impero

# Bundle app source
COPY . /src

# Change working directory
WORKDIR /src

# Expose port app is running on
EXPOSE 3000

# Install app dependencies
RUN npm install

CMD ["node", "--use_strict", "index.js"]
