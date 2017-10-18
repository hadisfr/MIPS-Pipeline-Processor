#!/usr/bin/env bash

if [[ ${1} == "comment" ]]; then
    sed -i "s/^\`include/\/\/\ \`include/g" ${@:2}
elif [[ ${1} == "uncomment" ]]; then
    sed -i "s/^\/\/\ \`include/\`include/g" ${@:2}
else
    echo "usage: ${0} [comment/uncomment] <file.v>"
fi
