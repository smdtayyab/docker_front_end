# This is similar to prod Docker file with multi steps in it.
# First Step to create the build
# Second step to use the build folder and deploy inside the nginx server.

# Adding below as the builder phase.
FROM node:16-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY ./ ./
RUN npm run build

# Next section to copy over the build from above section (builder phase).
FROM nginx 
COPY --from=builder /app/build /usr/share/nginx/html