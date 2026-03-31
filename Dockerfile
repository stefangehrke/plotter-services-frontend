FROM node:latest AS build
WORKDIR /app
COPY package.json ./
RUN ls -la
RUN npm install -g npm@11.12.1
RUN npm i
COPY . .
RUN npm run build

FROM nginx:alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist/plotter-services-frontend/browser /usr/share/nginx/html
EXPOSE 80
