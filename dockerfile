FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
#RUN export https_proxy=http://10.158.100.6:8080 && export http_proxy=http://10.158.100.6:8080
#RUN npm config set http-proxy http://10.158.100.6:8080 && npm config set https-proxy http://10.158.100.6:8080
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

