# -----------------------------------------------
# Stage 1: Build the React app
# -----------------------------------------------

# TODO: Use node:20-alpine as the base image, name this stage "build"
# Hint: FROM node:20-alpine AS build
FROM node:20-alpine AS build

# TODO: Set the working directory to /app
# Hint: WORKDIR /app
WORKDIR /app

# TODO: Copy package.json and package-lock.json first (use a wildcard)
# Hint: COPY package*.json ./
COPY package*.json ./

# TODO: Install dependencies using npm ci
# Hint: RUN npm ci
RUN npm ci

# Copy the rest of your code (already complete - do not change)
COPY . .

# TODO: Build the React app into the dist/ folder
# Hint: RUN npm run build
RUN npm run build
# -----------------------------------------------
# Stage 2: Serve with Nginx
# -----------------------------------------------

# TODO: Use nginx:alpine as the base image
# Hint: FROM nginx:alpine
FROM nginx:alpine
# TODO: Copy the built files from Stage 1 into Nginx's serving folder
# Hint: COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=build /app/dist /usr/share/nginx/html

# TODO: Copy your nginx.conf into Nginx's config folder
# Hint: COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

# TODO: Tell Docker this container uses port 80
# Hint: EXPOSE 80
EXPOSE 80

# NOTE: Do not add a CMD - nginx:alpine starts Nginx automatically.