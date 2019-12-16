#!/usr/bin/env bash
set -eu -o pipefail

ROOT="$(cd "${0%/*}" && pwd -P)"
BUILD="${ROOT}/build-clang-tidy"

export CLANG_TIDY_BIN="clang-tidy"
SCAN_BUILD_BIN="scan-build"
SCAN_BUILD_OUTPUT="${BUILD}/scan-build-Report"

if [[ "$OSTYPE" == "darwin"* ]]; then
    export CLANG_TIDY_BIN="$(brew --prefix llvm)/bin/${CLANG_TIDY_BIN}"
    SCAN_BUILD_BIN="$(brew --prefix llvm)/bin/${SCAN_BUILD_BIN}"
fi

mkdir -p "${BUILD}"
pushd "${BUILD}" &> /dev/null
    "${SCAN_BUILD_BIN}" -o "${SCAN_BUILD_OUTPUT}" \
    	cmake -DCMAKE_BUILD_TYPE=Release "${ROOT}"
    "${SCAN_BUILD_BIN}" -o "${SCAN_BUILD_OUTPUT}" \
        cmake --build . --
popd &>/dev/null
