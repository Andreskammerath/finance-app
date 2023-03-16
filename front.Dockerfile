# Use an existing Node.js image as the base image
FROM node:14

# Set the working directory in the container
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY fe-finance-app/package*.json ./

# Install the app's dependencies
RUN npm install

# Copy the rest of the app's files to the container
COPY fe-finance-app/* .

# Specify the command to run when the container starts
CMD ["npm", "start"]

# Expose port 3000, which is the default for a Create React App project
EXPOSE 3000
