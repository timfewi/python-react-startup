# Build stage
FROM node:20-alpine AS build
WORKDIR /app

# Copy npm config and manifests to install deps with legacy peer resolution for TS 5
COPY .npmrc package*.json ./
RUN npm install

# Copy the rest of the source and build
COPY . .
RUN npm run build

# Serve stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
