FROM node:20-slim

# Create app directory
WORKDIR /app

# Use production environment
ENV NODE_ENV=production
ENV PORT=8000

# Copy manifest files first for layer caching and deterministic installs
COPY package.json package-lock.json ./

# Install only production dependencies deterministically
RUN npm ci --only=production

# Copy application source and set ownership to non-root user
COPY --chown=node:node . .

# Use non-root user provided by the official image
USER node

# Expose the port the app listens on and default command
EXPOSE 8000
CMD ["npm", "start"]
