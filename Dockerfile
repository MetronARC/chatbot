# Use a lightweight Debian base image
FROM debian:bookworm-slim

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary dependencies
RUN apt update && apt install -y \
    curl python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama
RUN curl -fsSL https://ollama.ai/install.sh | sh

# Pull the DeepSeek model
RUN ollama pull deepseek-r1:1.5b

# Set work directory
WORKDIR /app

# Copy chatbot files
COPY . /app

# Install dependencies if using Python
RUN pip3 install -r requirements.txt  # Remove if your chatbot is Node.js-based

# Expose the application port
EXPOSE 80

# Start Ollama and the chatbot
CMD ollama serve --host 0.0.0.0 & python3 app.py  # Modify if using Node.js
