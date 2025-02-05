# Use Node.js as the base image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package.json ./
RUN npm install

# Copy the application code
COPY . .

# Expose the port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]