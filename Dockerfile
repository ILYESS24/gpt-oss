FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire project
COPY . .

# Install the package in development mode
RUN pip install -e .

# Expose port
EXPOSE 8000

# Default command (can be overridden by environment)
CMD ["python", "-m", "gpt_oss.responses_api.serve", "--port", "8000", "--inference-backend", "stub"]
