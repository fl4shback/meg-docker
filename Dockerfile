FROM node:lts as build

ENV FORCE_COLOR=0
WORKDIR /opt/docusaurus
COPY ./meg /opt/docusaurus/
RUN npm ci
RUN npm run build

FROM nginx:stable-alpine as serve

WORKDIR /opt/docusaurus
EXPOSE 80
COPY --from=build /opt/docusaurus/build /usr/share/nginx/html/
