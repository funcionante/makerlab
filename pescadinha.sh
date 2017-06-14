#!/bin/sh
pesca=$(<pescadinha.sh)
cd ..
jekyll build -d public
cd public
python -m SimpleHTTPServer 8002
echo "$pesca" > pescadinha.sh
