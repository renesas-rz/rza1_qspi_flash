#!/bin/sh

FLASH_ADDR=01F00000

# Load module
CHECK=`lsmod | grep qspi_flash`
if [ "$CHECK" == "" ] ; then
  insmod /root/module/qspi_flash.ko
fi

# Make our directory
mkdir -p /tmp/nvdata

# extract our tar file from QSPI Flash
qspi_app R d $FLASH_ADDR /tmp/nvdata.tar
cd /tmp
tar xf nvdata.tar
rm nvdata.tar

echo 'Extracted files now in /tmp/nvdata'

