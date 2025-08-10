# Use a minimal base image for the STUN server
FROM alpine:latest

# Install necessary runtime dependencies
RUN apk add --no-cache ca-certificates

# Set the working directory
WORKDIR /app

# Copy the STUN server binary
COPY stunserver /app/stunserver

# Make the binary executable
RUN chmod +x /app/stunserver

# Expose the STUN server port
EXPOSE 3478

# Set the default command
CMD ["./stunserver", "--primaryport", "3478"] 