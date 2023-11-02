FROM node:21-alpine3.17 as build

RUN apk add git
WORKDIR /usr/app
RUN cd /usr/app
COPY ./package*.json ./
RUN npm ci
COPY ./ ./
RUN PRODUCTION=1 npx webpack
RUN ls /usr/app/dist

FROM nginx:1.25.3-alpine
COPY --from=build /usr/app/dist /usr/share/nginx/html