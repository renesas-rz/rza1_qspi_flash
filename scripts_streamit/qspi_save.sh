#!/bin/sh

# Example for Stream it V2 boards

# Single QSPI Flash
# QSPI Flash size = 64MB (0x4000000)
# QSPI Flash offset to save data = 60MB (0x3C00000)
# QSPI Flash erase block size 64KB

FLASH_ADDR=3C00000

FLASH_ERASE_SIZE=65536

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

# Erase the number of blocks needed
SIZE=$(wc -c nvdata.tar | awk '{ print $1 }')

echo "File size is "$SIZE" bytes"
ERASE_ADDR=$FLASH_ADDR
while [ $SIZE -gt $FLASH_ERASE_SIZE ]
do
  echo "Erasing address "$ERASE_ADDR
  qspi_app e s $ERASE_ADDR

  # decrement file size
  NEWSIZE=$(expr $SIZE - $FLASH_ERASE_SIZE)
  SIZE=$NEWSIZE

  # include flash address
  NEWADDR=$((0x$ERASE_ADDR + $FLASH_ERASE_SIZE))
  ERASE_ADDR=$(printf '%X' $NEWADDR)
done

if [ $SIZE -gt 0 ] ; then
  echo "Erasing address "$ERASE_ADDR
  qspi_app e s $ERASE_ADDR
fi


# Program our TAR file into QSPI Flash
qspi_app P s $FLASH_ADDR nvdata.tar
rm /tmp/nvdata.tar

echo 'Files /tmp/nvdata have been backed up to QSPI Flash'

