FROM node:24-alpine AS builder

ARG vite_api_url
ENV VITE_API_URL=${vite_api_url}

WORKDIR /app

COPY package.json .
COPY package-lock.json .

RUN npm install

ENV PATH /app/node_modules/.bin:$PATH

COPY public/ ./public
COPY index.html .
COPY tsconfig* ./
#COPY vite.config.ts .
COPY src/ ./src

RUN npm run build

FROM nginx:latest

RUN mkdir /var/www && mkdir /var/www/logs

COPY --from=builder /app/dist /usr/share/nginx/html

COPY dockerfile/nginx.conf /etc/nginx/conf.d/default.conf
