FROM node:16-alpine

WORKDIR /app

COPY package.json .
RUN npm install -g @nestjs/cli
RUN npm install --save @nestjs/typeorm typeorm mysql2

COPY . .

CMD ["npm", "run","start:dev"]