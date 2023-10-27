#!/bin/bash

set -e

# pwd
# shell exec用被执行的命令行替换掉当前的shell进程，且exec命令后的其他命令将不再执行
exec java ${JAVA_OPTS} -jar sentinel-dashboard.jar "$@"
