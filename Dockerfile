# Stage 1: Build the TypeScript application
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json tsconfig.json ./
COPY src/ ./src
RUN npm install && npm run build

# Stage 2: Run the compiled application
FROM node:20-alpine
WORKDIR /app

# FIXED: Install curl while we are still the ROOT user
RUN apk add --no-cache curl

COPY package*.json ./
RUN npm install --omit=dev
COPY --from=builder /app/dist ./dist

# Now safely switch to the non-root user
USER node
EXPOSE 3000

CMD ["node", "dist/app.js"]
