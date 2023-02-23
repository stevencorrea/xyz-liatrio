# syntax=docker/dockerfile:1

FROM node:lts-alpine
ENV NODE_ENV=production

WORKDIR /app

COPY ["package.json", "package-lock.json*", "./"]

RUN npm install --omit-dev

COPY . .

CMD [ "node", "start.js" ]