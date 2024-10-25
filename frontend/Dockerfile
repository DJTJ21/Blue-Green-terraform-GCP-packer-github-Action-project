
FROM node:18-alpine as builder

WORKDIR /usr/app

COPY ./package*.json ./

RUN npm install 

COPY ./ ./

COPY src src

RUN npm run build --output-path=./dist/frontend --prod


FROM nginx:alpine

COPY --from=builder /usr/app/dist/frontend /usr/share/nginx/html

COPY ./nginx-custom.conf /etc/nginx/

CMD envsubst < /etc/nginx/nginx-custom.conf > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
