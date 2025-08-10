#!/bin/bash

# Script to build Linux binary for Railway deployment
# This script assumes you have access to the source code

echo "=== STUN Server Linux Binary Builder ==="
echo "This script helps you build a Linux-compatible binary for Railway deployment."
echo ""

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed to run on macOS to cross-compile for Linux."
    exit 1
fi

echo "Current system: $(uname -s) $(uname -m)"
echo "Target system: Linux x86_64"
echo ""

# Check for common build tools
echo "Checking build dependencies..."

# Check for Go (if it's a Go project)
if command -v go &> /dev/null; then
    echo "✓ Go found: $(go version)"
    echo "You can cross-compile with:"
    echo "  GOOS=linux GOARCH=amd64 go build -o stunserver-linux ./path/to/source"
    echo ""
fi

# Check for gcc (if it's a C/C++ project)
if command -v gcc &> /dev/null; then
    echo "✓ GCC found: $(gcc --version | head -n1)"
    echo "You can cross-compile with:"
    echo "  gcc -o stunserver-linux source.c -static"
    echo ""
fi

# Check for clang (if it's a C/C++ project)
if command -v clang &> /dev/null; then
    echo "✓ Clang found: $(clang --version | head -n1)"
    echo "You can cross-compile with:"
    echo "  clang -o stunserver-linux source.c -static"
    echo ""
fi

# Check for Docker (for cross-compilation)
if command -v docker &> /dev/null; then
    echo "✓ Docker found: $(docker --version)"
    echo "You can use Docker for cross-compilation:"
    echo "  docker run --rm -v \$(pwd):/src -w /src golang:alpine go build -o stunserver-linux ./path/to/source"
    echo ""
fi

echo "=== Next Steps ==="
echo "1. If you have source code, use one of the cross-compilation commands above"
echo "2. Replace the 'stunserver' binary in your project with the Linux version"
echo "3. Update the Dockerfile to remove the --platform flag"
echo "4. Deploy to Railway"
echo ""
echo "=== Alternative Solutions ==="
echo "1. Use Railway's native deployment (if supported)"
echo "2. Deploy to a Linux-based VPS instead"
echo "3. Use a different containerization strategy" 