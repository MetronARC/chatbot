# Use a lightweight Debian base image
FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt update && apt install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | sh

# Pull the DeepSeek model
RUN ollama pull deepseek-r1:1.5b

# Set work directory
WORKDIR /app

# Copy chatbot files
COPY . /app

# Expose the application port
EXPOSE 80

# Start Ollama and serve static files using Python's built-in HTTP server
CMD ollama serve --host 0.0.0.0 & python3 -m http.server 80
