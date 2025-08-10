# Railway Deployment Guide for STUN Server

This guide explains how to deploy your STUN server to Railway.

## Prerequisites

1. **Railway Account**: Sign up at [railway.app](https://railway.app)
2. **Railway CLI** (optional but recommended):
   ```bash
   npm install -g @railway/cli
   ```

## Deployment Steps

### 1. Connect Your Repository

1. Go to [Railway Dashboard](https://railway.app/dashboard)
2. Click "New Project"
3. Select "Deploy from GitHub repo"
4. Choose your repository

### 2. Configure the Project

Railway will automatically detect the `railway.toml` configuration and use the `Dockerfile` for building.

### 3. Environment Variables (if needed)

If your STUN server requires any environment variables, add them in the Railway dashboard under the "Variables" tab.

### 4. Deploy

Railway will automatically:
- Build the Docker image using the provided `Dockerfile`
- Deploy the container
- Start the STUN server with the command: `./stunserver --primaryport 3478`

### 5. Access Your Server

Once deployed, Railway will provide you with:
- A public URL for your service
- The port mapping (3478)

## Configuration Details

### Port Configuration
- **Primary Port**: 3478 (STUN protocol standard)
- **Health Check**: Configured to verify the server is running

### Build Process
- Uses Alpine Linux for minimal image size
- Copies only the `stunserver` binary
- Sets proper permissions and working directory

### Health Monitoring
- Railway will automatically restart the service if it fails
- Health checks verify the server is listening on port 3478

## Troubleshooting

### Common Issues

1. **Port Already in Use**: Ensure port 3478 is available
2. **Binary Permissions**: The Dockerfile sets proper execute permissions
3. **Health Check Failures**: Verify the server starts successfully

### Critical Issue: "Exec format error"

**Error**: `exec container process '/app/./stunserver': Exec format error`

**Cause**: This error occurs when the binary architecture doesn't match the container architecture. Your `stunserver` binary was compiled for macOS (darwin) but Railway's Docker containers run on Linux.

**Solutions**:

#### Option 1: Cross-compile for Linux (Recommended)
If you have access to the source code:

1. **For Go projects**:
   ```bash
   GOOS=linux GOARCH=amd64 go build -o stunserver-linux ./path/to/source
   ```

2. **For C/C++ projects**:
   ```bash
   gcc -o stunserver-linux source.c -static
   ```

3. **Using Docker for cross-compilation**:
   ```bash
   docker run --rm -v $(pwd):/src -w /src golang:alpine go build -o stunserver-linux ./path/to/source
   ```

4. Replace the binary and remove the `--platform=linux/amd64` flag from Dockerfile

#### Option 2: Use Alternative Dockerfile
Use `Dockerfile.source` which builds from source (requires source code access)

#### Option 3: Build Script
Run the provided `build-linux-binary.sh` script to check your build environment

### Logs
Check Railway logs in the dashboard to debug any issues:
- Build logs: Show Docker build process
- Runtime logs: Show STUN server output

## Customization

### Modify Port
To change the port, update both:
- `railway.toml` - Update the port number
- `Dockerfile` - Update EXPOSE and CMD

### Add Environment Variables
If you need to configure the server via environment variables, add them to the Railway dashboard and modify the Dockerfile accordingly.

## Security Considerations

- The STUN server runs on the standard STUN port (3478)
- Consider implementing rate limiting if needed
- Monitor for abuse or excessive connections

## Support

For Railway-specific issues, check the [Railway documentation](https://docs.railway.app/).
For STUN server issues, check your server logs and configuration. 