#!/bin/bash
echo "SCRIPT STARTED"
case "$1" in

build_generator)
    docker build -t generator-image ./generator
    ;;

run_generator)
    mkdir -p data
    MSYS_NO_PATHCONV=1 docker run --rm \
      -v "$(pwd)/data:/data" \
      generator-image \
      python generate.py /data
    ;;
    
create_local_data)
    mkdir -p local_data
    python generator/generate.py local_data
    ;;

build_reporter)
    docker build -t reporter-image ./reporter
    ;;

run_reporter)
    mkdir -p data
    MSYS_NO_PATHCONV=1 docker run --rm \
      -v "$(pwd)/data:/data" \
      reporter-image
    ;;
    
structure)
    find .
    ;;

clear_data)
    rm -f data/*.csv data/*.html
    ;;

inside_generator)
    MSYS_NO_PATHCONV=1 docker run --rm \
      -v "$(pwd)/data:/data" \
      generator-image \
      ls -la /data
    ;;

inside_reporter)
    MSYS_NO_PATHCONV=1 docker run --rm \
      -v "$(pwd)/data:/data" \
      reporter-image \
      ls -la /data
    ;;

report_server)
    docker stop report-server 2>/dev/null
    docker rm report-server 2>/dev/null
    MSYS_NO_PATHCONV=1 docker run --rm -d \
      -p 8080:80 \
      -v "$(pwd)/data:/usr/share/nginx/html:ro" \
      nginx:alpine
    echo "Web server started on http://localhost:8080/report.html"
    ;;
*)
    echo "Commands:"
    echo "./run.sh build_generator"
    echo "./run.sh run_generator"
    echo "./run.sh create_local_data"
    echo "./run.sh build_reporter"
    echo "./run.sh run_reporter"
    echo "./run.sh structure"
    echo "./run.sh clear_data"
    echo "./run.sh inside_generator"
    echo "./run.sh inside_reporter"
    echo "./run.sh report_server"
    ;;
esac