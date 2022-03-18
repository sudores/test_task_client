FROM node:14.17.0-alpine3.13 AS build
LABEL stage=build
WORKDIR /build
COPY . .
ARG base_url='http:\/\/test-task.ttk.loc'
RUN set -e ; \
        sed -ie "s/test_url_test/$base_url/g" src/API.ts; \
        yarn; \
        yarn build

FROM nginx:1.21.6-alpine
WORKDIR /app
COPY --from=build /build/build/ /app
COPY app.conf /etc/nginx/conf.d/
