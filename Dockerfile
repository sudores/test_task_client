FROM node:14.17.0-alpine3.13 AS build
WORKDIR /build
COPY . .
RUN yarn; yarn build

FROM nginx:1.21.6-alpine
WORKDIR /app
COPY --from=build /build/build/ /app
COPY app.conf /etc/nginx/conf.d/
