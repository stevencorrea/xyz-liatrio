# syntax=docker/dockerfile:1

FROM node:lts-alpine
ENV NODE_ENV=production

WORKDIR /

COPY ["app/", "./"]

RUN npm install express
RUN npm install --omit-dev

COPY . .

EXPOSE 3000/tcp

CMD [ "node", "start.js" ]