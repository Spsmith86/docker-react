#Create the Builder phase where we create the static files
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
#Open port 80 in ELB
EXPOSE 80
#From the stage above, copy the build folder into nginx
COPY --from=builder /app/build /usr/share/nginx/html