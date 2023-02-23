# syntax=docker/dockerfile:1

FROM node:lts-alpine
ENV NODE_ENV=production

WORKDIR /xyzapp

COPY ["app/package.json", "app/package-lock.json", "./"]

RUN npm install --omit-dev

COPY . .

EXPOSE 3000/tcp

CMD [ "node", "start.js" ]