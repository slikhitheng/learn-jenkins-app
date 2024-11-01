
FROM node:18.20.4-alpine

WORKDIR /react-dev-app

COPY package*.json .

RUN npm install

COPY . /react-dev-app

EXPOSE 3000

CMD [ "npm", "start" ]