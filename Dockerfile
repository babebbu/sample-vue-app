ARG BUILD_MODE=production

### STAGE 1:BUILD ###
FROM node:18 AS build
WORKDIR /app
RUN npm cache clean --force
COPY . .
RUN pwd
RUN ls
RUN npm install
RUN npm run build --configuration=$BUILD_MODE

### STAGE 2:RUN ###
FROM nginx:latest
RUN rm -f /usr/share/nginx/html/index.html
COPY --from=build /app/dist/* /usr/share/nginx/html
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80