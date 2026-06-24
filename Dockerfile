# ==============================
# Stage 1: Build React App
# ==============================
FROM node:18 AS build

WORKDIR /app

COPY package*.json ./

RUN npm install --legacy-peer-deps

COPY . .

ENV CI=false
ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm run build


# ==============================
# Stage 2: Production Server
# ==============================
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
