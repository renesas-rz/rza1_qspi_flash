#!/bin/sh

# Example for Stream it V2 boards

# Single QSPI Flash
# QSPI Flash size = 64MB (0x4000000)
# QSPI Flash offset to save data = 60MB (0x3C00000)

FLASH_ADDR=3C00000

# Load module
CHECK=`lsmod | grep qspi_flash`
if [ "$CHECK" == "" ] ; then
  insmod /root/module/qspi_flash.ko
fi

# Make our directory
mkdir -p /tmp/nvdata

# extract our tar file from QSPI Flash
qspi_app R s $FLASH_ADDR /tmp/nvdata.tar
cd /tmp
tar xf nvdata.tar
rm nvdata.tar

echo 'Extracted files now in /tmp/nvdata'

