# Use a multi-architecture base image for better compatibility
FROM --platform=linux/amd64 alpine:latest

# Install necessary runtime dependencies
RUN apk add --no-cache ca-certificates

# Set the working directory
WORKDIR /app

# Copy the STUN server binary
COPY stunserver /app/stunserver

# Make the binary executable
RUN chmod +x /app/stunserver

# Verify the binary architecture (debugging)
RUN file /app/stunserver || echo "Binary architecture check failed"

# Expose the STUN server port
EXPOSE 3478

# Set the default command
CMD ["./stunserver", "--primaryport", "3478"] 