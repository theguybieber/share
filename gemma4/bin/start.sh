#!/bin/bash
# start.sh - Launch and Test Gemma 4 31B

OS="$(uname)"
PORT=8000

if [[ "$OS" == "Darwin" ]]; then
    # Mac: MLX Native
    vllm-mlx serve mlx-community/gemma-4-31b-it-4bit --port $PORT &
else
    # Linux/Windows: TurboQuant KV-Compression (3.5-bit sweet spot)
    turboquant-vllm serve google/gemma-4-31b-it \
        --kv-quant-scheme turboquant --kv-bits 3.5 --port $PORT &
fi

echo "🚀 Spinning up Gemma 4 31B..."
sleep 8 # Brief wait for VRAM/Unified Memory allocation

# Open the simple Swagger UI to test the model
URL="http://localhost:$PORT/docs"
if [[ "$OS" == "Darwin" ]]; then open "$URL"; 
elif command -v xdg-open >/dev/null 2>&1; then xdg-open "$URL"; 
else start "$URL"; fi

