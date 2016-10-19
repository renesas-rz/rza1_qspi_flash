# XIP Linux QSPI Flash Reprogramming Module

Sample driver for erase/program/read of QSPI flash while executing an XIP kernel out of the QSPI flash.
While communcating with the SPI flash, system will be off and the QSPI peripheral will be in SPI mode meaning no kernel functions can be called.


If using the Renesas BSP with the RZ/A1 RSK board, you can do the following to try it out.


1. Change into the directory of your RSK BSP
```
cd rskrza1_bsp
```

2. Set up the build environment
```
export ROOTDIR=$(pwd) ; source ./setup_env.sh
```

3. Pull down this project
```
git clone https://github.com/renesas-rz/rza1_qspi_flash.git
```

4. Build the driver module and app, add it to your AXFS file system
```
cd rza1_qspi_flash
make
make insall
cd ..
./build.sh buildroot
./build.sh axfs
```

5. Reprogram the rootfs on your board. For example:
```
./build.sh jlink output/axfs/rootfs.axfs.bin
```

6. Boot your system

7. Do an initial save:
```
qspi_save.sh
````
8. Now add whatever files you want to /tmp/nvdata (since everythign under /tmp is R/W).

9. At any time, you can save the contents of /tmp/nvdata to QSPI flash by typing "qspi_save.sh"

10. Next time you boot, enter this command to restore your files to /tmp/nvdata
```
qspi_restore.sh
````
