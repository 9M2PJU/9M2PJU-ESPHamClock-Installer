# Multi-stage Dockerfile for HamClock (Open HamClock / OHB Edition)
# Pre-builds all web resolutions for instant resolution switching via environment variable

# ------------------------------------------------------------------------------
# Stage 1: Build Environment
# ------------------------------------------------------------------------------
FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    make \
    g++ \
    pkg-config \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY . .

# Build all web targets and save binaries to /build/bin
RUN mkdir -p /build/bin && \
    make hamclock-web-800x480 -j$(nproc) && mv hamclock-web-800x480 /build/bin/ && make clean && \
    make hamclock-web-1600x960 -j$(nproc) && mv hamclock-web-1600x960 /build/bin/ && make clean && \
    make hamclock-web-2400x1440 -j$(nproc) && mv hamclock-web-2400x1440 /build/bin/ && make clean && \
    make hamclock-web-3200x1920 -j$(nproc) && mv hamclock-web-3200x1920 /build/bin/ && make clean

# ------------------------------------------------------------------------------
# Stage 2: Minimal Runtime Environment
# ------------------------------------------------------------------------------
FROM debian:bookworm-slim AS runner

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    tzdata \
 && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -u 1000 -m -s /bin/bash hamclock

# Copy pre-compiled web binaries from builder
COPY --from=builder /build/bin/hamclock-web-800x480  /usr/local/bin/hamclock-web-800x480
COPY --from=builder /build/bin/hamclock-web-1600x960 /usr/local/bin/hamclock-web-1600x960
COPY --from=builder /build/bin/hamclock-web-2400x1440 /usr/local/bin/hamclock-web-2400x1440
COPY --from=builder /build/bin/hamclock-web-3200x1920 /usr/local/bin/hamclock-web-3200x1920

# Create symlink for default binary
RUN ln -s /usr/local/bin/hamclock-web-800x480 /usr/local/bin/hamclock

# Copy entrypoint script
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# Set working directory and volume for user data
USER hamclock
WORKDIR /home/hamclock
VOLUME ["/home/hamclock/.hamclock"]

# Expose HamClock Ports:
# 8080: RESTful HTTP API & Screenshots (/live.png)
# 8081: Real-time Interactive WebSocket Web Interface (/live.html)
# 8082: Read-Only Live Web Interface
EXPOSE 8080 8081 8082

# Default Resolution environment variable (800x480, 1600x960, 2400x1440, 3200x1920)
ENV RESOLUTION=800x480

ENTRYPOINT ["/docker-entrypoint.sh"]
