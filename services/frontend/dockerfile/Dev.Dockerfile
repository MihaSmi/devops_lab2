FROM node:24-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

ENV PATH="/app/node_modules/.bin:$PATH"

COPY public/ ./public
COPY index.html .
COPY tsconfig* ./
#COPY vite.config.ts .
COPY src/ ./src

ENTRYPOINT ["npm", "run", "dev", "--", "--host", "0.0.0.0"]
