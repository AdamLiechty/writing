# syntax=docker/dockerfile:1

# 🧱 Base stage (shared setup)
FROM node:24-slim AS base
WORKDIR /app

# git + ssh needed for `docusaurus deploy`
RUN apt-get update \
  && apt-get install -y --no-install-recommends git openssh-client ca-certificates \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /root/.ssh \
  && ssh-keyscan -t ed25519 github.com >> /root/.ssh/known_hosts \
  && chmod 700 /root/.ssh

# Copy only package files first for better layer caching
COPY package*.json ./

# Install dependencies inside the container
RUN npm ci --ignore-scripts

# Copy app code
COPY . .

# 🧑‍💻 Dev stage
FROM base AS dev
ENV NODE_ENV=development
EXPOSE 3000
CMD ["npm", "run", "start", "--", "--host", "0.0.0.0", "--port", "3000"]

# 📦 CI stage (build-only)
FROM base AS ci
ENV NODE_ENV=production
CMD ["npm", "run", "build"]

# 🏗️ Build stage
FROM base AS build
ENV NODE_ENV=production
RUN npm run build

# 🚀 Production runtime (static site)
FROM node:24-alpine AS prod
WORKDIR /app
ENV NODE_ENV=production

COPY package*.json ./
RUN npm ci --omit=dev --ignore-scripts

COPY --from=build /app/build ./build
COPY --from=build /app/docusaurus.config.js ./
COPY --from=build /app/babel.config.js ./
COPY --from=build /app/sidebars.js ./

EXPOSE 3000
CMD ["npm", "run", "serve", "--", "--host", "0.0.0.0", "--port", "3000"]
