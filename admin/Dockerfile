# Production Dockerfile for MedusaJS
FROM node:20-alpine AS base
WORKDIR /app

# Copy the entire admin directory
COPY admin/ ./admin/

# Change to admin directory and build
WORKDIR /app/admin
RUN yarn install --frozen-lockfile
RUN npx medusa build

# Move to server directory
WORKDIR /app/admin/.medusa/server

# Install production dependencies
RUN yarn install --production --frozen-lockfile

# Copy environment variables
COPY ../../.env.production .env.production

EXPOSE 9000

# Start Medusa in production mode
CMD ["sh", "-c", "NODE_ENV=production yarn run start"] 