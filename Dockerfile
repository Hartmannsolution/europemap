# Use the official Node image as a base image
FROM node:14-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Vite app
RUN npm run build

# Install 'pm2' and 'serve' globally (if not already installed)
RUN npm install -g serve
RUN npm install -g pm2

# Expose the port that your app is running on
EXPOSE 5000

# Command to run your app using 'pm2' and 'serve' on port 5000 (for production as --spa (single page application))
CMD ["pm2", "serve", "dist", "5000", "--spa"]
