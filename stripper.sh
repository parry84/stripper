#!/bin/bash

SHORT=d:,i:,o:,h
LONG=dir:,input:,output:,help
OPTS=$(getopt -a -n stripper --options $SHORT --longoptions $LONG -- "$@")

eval set -- "$OPTS"

while :
do
  case "$1" in
    -d | --dir )
      dir="$2"
      shift 2
      ;;
    -i | --input )
      input="$2"
      shift 2
      ;;
    -o | --output )
      output="$2"
      shift 2
      ;;
    -h | --help)
      cat ./README.md
      exit 2
      ;;
    --)
      shift;
      break
      ;;
    *)
      echo "Unexpected option: $1"
      ;;
  esac
done

if [ "$(docker images -q parry84/stripper:1.0.0 2> /dev/null)" == "" ]; then
  docker build --tag parry84/stripper:1.0.0 .
fi

if [ -d "${dir}" ]; then
  find "${dir}" -type f -name "*.pdf" -print0 | while IFS= read -r -d '' file; do
    mkdir --parent "${dir}.stripped"
    cat "${file}" | docker run --rm -i stripper > "${dir}.stripped/$(basename "${file}")"
  done
else
  cat -- "${input--}" | docker run --rm -i parry84/stripper:1.0.0 > "${output:-/dev/stdout}"
fi
