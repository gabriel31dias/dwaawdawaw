FROM node:18-alpine

WORKDIR /app

# Enable corepack for yarn
RUN corepack enable

# Copy package files
COPY package.json yarn.lock ./
COPY .yarnrc.yml* ./

# Copy workspace package files
COPY api/package.json ./api/
COPY frontend/package.json ./frontend/

# Install root dependencies
RUN yarn install --frozen-lockfile

# Copy all source code
COPY . .

# Install workspace dependencies
RUN yarn workspaces focus api --production

# Expose port (Render uses PORT env variable)
EXPOSE 8000

# Start the API server
CMD ["yarn", "workspace", "api", "start"]
