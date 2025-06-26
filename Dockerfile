FROM node:alpine

RUN apk add --update-cache git \
	&& rm -rf /var/cache/apk/*

COPY /package*.json /app/
WORKDIR /app
RUN npm install --production

COPY . /app
RUN npm link webpack-cli
RUN npm run build
RUN npm install mongodb

EXPOSE 7007

CMD node webstrates.js
