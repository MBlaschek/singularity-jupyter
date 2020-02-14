#!/usr/bin/env bash


#
# Singularity RTTOV Example and Steps
#
RTTOV_CONTAINER=jrttov
# 1. Download RTTOV Coefficients
mkdir -f rtceof
# Bind local path to rtcoef, emis and brdf
export SINGULARITY_BIND="${PWD}/rtcoef:/rtcoef,${PWD}/emis_data:/emis_data,${PWD}/brdf_data:/brdf_data"
# initiate coef download
singularity run $RTTOV_CONTAINER rtcoef execute
# initiate atlas download
singularity run $RTTOV_CONTAINER atlas execute
# 2. Test RTTOV installation
singularity run $RTTOV_CONTAINER rttest
singularity run $RTTOV_CONTAINER rttest fwd
# 3. Run Example Python interface
singularity run $RTTOV_CONTAINER ipython <<EOF
cd /rttov/wrapper
%run pyrttov_example.py
print(seviriRttov.Profiles.printGases())
EOF


# Create a persistent overlay image
mkdir -p overlay/upper/rttov/wrapper
# touch overlay/upper/rttov/wrapper/Makefile   # this overwrites the file in the container
# create image
dd if=/dev/zero of=overlay.img bs=1M count=500 && mkfs.ext3 -d overlay overlay.img

singularity shell --overlay overlay.img $RTTOV_CONTAINER

