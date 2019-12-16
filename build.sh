#!/usr/bin/env bash
set -eu -o pipefail

ROOT="$(cd "${0%/*}" && pwd -P)"
BUILD="build"

mkdir -p "${BUILD}"
pushd "${BUILD}" &> /dev/null
    cmake -DCMAKE_BUILD_TYPE=Release "${ROOT}"
    cmake --build .
popd &>/dev/null
