# Production Dockerfile for MedusaJS
FROM node:20-alpine AS base
WORKDIR /app

# Copy build output
COPY .medusa/server/ ./

# Install dependencies
RUN yarn install --production --frozen-lockfile

# Copy environment variables
COPY .env.production .env.production

EXPOSE 9000

# Start Medusa in production mode
CMD ["sh", "-c", "NODE_ENV=production yarn run start"] 