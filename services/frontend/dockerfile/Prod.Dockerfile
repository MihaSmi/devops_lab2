FROM node:24-alpine AS builder
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:latest
RUN mkdir /var/www && mkdir /var/www/logs
COPY --from=builder /app/dist /usr/share/nginx/html
