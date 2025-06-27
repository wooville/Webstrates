FROM node:alpine

RUN apk add --update-cache git \
	&& rm -rf /var/cache/apk/*

RUN sudo apt-get install -y gnupg curl\
	curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
	sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg \
	--dearmor \
	echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list \
	sudo apt-get update \
	sudo apt-get install -y mongodb-org

COPY /package*.json /app/
WORKDIR /app
RUN npm install --production

COPY . /app
RUN npm link webpack-cli
RUN npm run build

EXPOSE 7007

CMD node webstrates.js
