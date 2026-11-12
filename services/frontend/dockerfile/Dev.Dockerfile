FROM node:24-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

ENV PATH="/app/node_modules/.bin:$PATH"

ARG vite_api_url
ENV VITE_API_URL=${vite_api_url}

COPY public/ ./public
COPY tsconfig*.json ./
COPY index.html ./
COPY vite.config.ts ./
COPY src/ ./src

RUN npm run build
