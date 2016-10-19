#!/bin/sh

FLASH_ADDR=01F00000

# Load module
CHECK=`lsmod | grep qspi_flash`
if [ "$CHECK" == "" ] ; then
  insmod /root/module/qspi_flash.ko
fi

# Make our directory if it does not exist already
if [ ! -e /tmp/nvdata ] ; then
  mkdir /tmp/nvdata
fi

# Create a TAR file of our directory and save to QSPI Flash
cd /tmp
tar c nvdata > /tmp/nvdata.tar

# Program our TAR file into QSPI Flash
qspi_app e d $FLASH_ADDR
qspi_app P d $FLASH_ADDR nvdata.tar
rm /tmp/nvdata.tar

echo 'Files /tmp/nvdata have been backed up to QSPI Flash'

