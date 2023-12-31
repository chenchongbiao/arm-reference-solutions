#!/bin/bash

# Copyright (c) 2023, Arm Limited. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# Redistributions in binary form must reproduce the above copyright notice,
# this list of conditions and the following disclaimer in the documentation
# and/or other materials provided with the distribution.
#
# Neither the name of ARM nor the names of its contributors may be used
# to endorse or promote products derived from this software without specific
# prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

do_build() {

    info_echo "Downloading Debian 12 image from Linaro"
    TEMP_FILE=.tmp
    pushd $DEPLOY_DIR/tc2

    if [ ! -f $DEBIAN_IMG ]; then
        wget --output-document=${TEMP_FILE}  ${DEBIAN_LINARO_PATH}/${DEBIAN_IMG}
        checksum=`md5sum ${TEMP_FILE} | sed 's/\|/ /'|awk '{print $1}'`

        if [ $checksum != $DEBIAN_CHECKSUM ]; then
            error_echo "Debian 12 Image Checksum validation failed"
            rm ${TEMP_FILE}
            exit
        else
            mv ${TEMP_FILE} ${DEBIAN_IMG}
        fi
    else
        info_echo "Debian 12 image already exists; skipping the download process."
    fi

    $SCRIPT_DIR/create_mmc_image.sh
    popd
}

do_clean() {
    info_echo "Cleaning debian"
    rm -rf $DEPLOY_DIR/tc2/debian_fs.img
    rm -rf $DEPLOY_DIR/tc2/debian.img
}

do_patch() {
    info_echo "Patching for debian"
    # This is not to patch debian filesystem.
    # use it to patch TC components to support booting debian, if any.
}

do_deploy() {
    info_echo "Deploying debian"
}
source "$(dirname ${BASH_SOURCE[0]})/framework.sh"
