# Use the official Node.js image as a parent image
FROM node:18.20.4-alpine

# Set the working directory in the container
WORKDIR /react-dev-app

# Copy package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application files
COPY . /react-dev-app

# Build the React application
# RUN npm run build

# Install serve to serve the build folder
# RUN npm install -g serve

# Expose the port the app runs on
EXPOSE 3000

# Command to run the application
# CMD ["serve", "-s", "build"]
CMD [ "npm", "start" ]
