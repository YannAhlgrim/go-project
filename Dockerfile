# Use the official Golang image as the base image
FROM golang:1.23-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the Go module files and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code into the container
COPY . .

# Build the Go application
RUN go build -o main .

# Copy the ollama.sh script and make it executable
COPY ollama.sh .
RUN chmod +x ollama.sh

# Expose the port that the application will run on and port 11434 for the Ollama API
EXPOSE 8080
EXPOSE 11434

# Set the entry point to run the ollama.sh script and then the Go application
ENTRYPOINT ["./ollama.sh", "&&", "./main"]