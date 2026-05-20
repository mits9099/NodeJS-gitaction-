# Stage 1: Build the TypeScript application
FROM node:20-alpine AS builder
WORKDIR /app
RUN apk add --no-cache curl # Adds curl to the container
COPY package*.json tsconfig.json ./
COPY src/ ./src
RUN npm install && npm run build

# Stage 2: Run the compiled application
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install --only=production
COPY --from=builder /app/dist ./dist

USER node
EXPOSE 3000

CMD ["node", "dist/app.js"]
