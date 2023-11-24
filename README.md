# Deployment guide
This is a guide to deploy a react vite app to Digital Ocean using Docker and Github Actions.

## Steps
1. Create a droplet on Digital Ocean
2. Create a new project on Github
3. Create a new repository on Github
4. Clone the repository to your local machine
5. Create a new react vite app
6. Push the app to Github
7. Create a Dockerfile with the following steps:
  - Use the official Node image as a base image
  - Copy package.json and package-lock.json to the container
  - Install dependencies
  - Copy the rest of the application code to the container
  - Build the Vite app (to get the dist folder)
  - Install `pm2` and `serve` globally to run the app
  - Expose the port that your app is running on in order to access it from outside the container
  - Command to run your app using `pm2` and `serve` on port 5000 (for production as `--spa` (single page application))
8. Create a docker-compose.yml file
9. Create a Github Actions workflow
  - 
10. Push the changes to Github
11. Check the Github Actions workflow
12. Check the Docker Hub repository
13. Check the Digital Ocean droplet
14. Check the app in the browser

### pm2 debugging
- `pm2 list` - list all running processes
- `pm2 logs` - show logs for all processes
- `pm2 logs 0` - show logs for process with id 0
- `pm2 stop 0` - stop process with id 0
- `pm2 restart 0` - restart process with id 0
- `pm2 delete all` - delete all processes
- `pm2 delete 0` - delete process with id 0

## Docker file
The docker file will be used to build the image for the app. The image will be used to run the app in a container.

```dockerfile
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
```

## Github workflow file
The Github workflow file will be used to build the image and push it to Docker Hub.

```yaml
name: Deploy to Docker Hub

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Build and push Docker image
        env:
          DOCKER_USERNAME: ${{ secrets.DOCKER_USERNAME }}
          DOCKER_PASSWORD: ${{ secrets.DOCKER_PASSWORD }}
        run: |
          echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
          docker build -t your-docker-username/your-app-name:latest .
          docker push your-docker-username/your-app-name:latest
```


