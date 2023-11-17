#!/bin/bash

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Usage:
#     bash download_dataset.sh ${DATASET_NAME} ${OUTPUT_DIR}
# Example:
#     bash download_dataset.sh WaterDrop /tmp/

set -e

DATASET_NAME="${1}"
OUTPUT_DIR="${2}/${DATASET_NAME}"

BASE_URL="https://storage.googleapis.com/learning-to-simulate-complex-physics/Datasets/${DATASET_NAME}/"

mkdir -p "${OUTPUT_DIR}"

download() {
    local url="${1}"
    local output_path="${2}"

    if command -v wget > /dev/null; then
        wget -O "${output_path}" "${url}"
    elif command -v curl > /dev/null; then
        curl -o "${output_path}" "${url}"
    else
        echo "Error: wget or curl is required for downloading."
        exit 1
    fi
}

for file in metadata.json train.tfrecord valid.tfrecord test.tfrecord
do
    download "${BASE_URL}${file}" "${OUTPUT_DIR}/${file}"
done
