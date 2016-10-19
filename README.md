# XIP Linux QSPI Flash Reprogramming Module

Sample driver for erase/program/read of QSPI flash while executing an XIP kernel out of the QSPI flash.
While communcating with the SPI flash, system will be off and the QSPI peripheral will be in SPI mode meaning no kernel functions can be called.


If using the Renesas BSP with the RZ/A1 RSK board, you can do the following to try it out.


* Change into the directory of your RSK BSP
```
cd rskrza1_bsp
```

* Set up the build environment
```
export ROOTDIR=$(pwd) ; source ./setup_env.sh
```

* Pull down this project
```
git clone https://github.com/renesas-rz/rza1_qspi_flash.git
```

* Build the driver module and app, add it to your AXFS file system
```
cd rza1_qspi_flash
make
make install
cd ..
./build.sh buildroot
./build.sh axfs
```

* Reprogram the rootfs on your board. For example:
```
./build.sh jlink output/axfs/rootfs.axfs.bin
```

* Boot your system

* On your RZ/A board, do an initial save:
```
qspi_save.sh
````
* Now add whatever files you want to /tmp/nvdata (since everythign under /tmp is R/W).

* At any time, you can save the contents of /tmp/nvdata to QSPI flash by typing "qspi_save.sh"

* Next time you boot, enter this command to restore your files to /tmp/nvdata
```
qspi_restore.sh
````
