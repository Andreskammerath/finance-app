# Use an official Python runtime as the base image
FROM python:3.10

# Set the working directory in the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt .

# Install the required packages
RUN pip install -r requirements.txt

# Copy the source code to the container
COPY . .

# Set environment variables
ENV PYTHONUNBUFFERED 1

# Expose the default port for the FastAPI application
EXPOSE 8000

# Run the application using the default command
CMD ["uvicorn", "main:api", "--host", "0.0.0.0", "--port", "8000", "--reload"]
