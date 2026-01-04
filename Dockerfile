FROM python:3.10-slim AS builder

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .


# Install Python dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir --prefix=/install -r requirements.txt

# -------------------------
# 🚀 Stage 2: Runtime stage
# -------------------------

FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Create a non-root user
RUN adduser --disabled-password --no-create-home appuser

# Set Workdir 

WORKDIR /app

# Copy installed packages from builder
COPY --from=builder /install /usr/local

COPY app.py .

# Change to non-root user
USER appuser

EXPOSE 8000

CMD ["python", "app.py"]

