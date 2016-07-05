# XIP Linux QSPI Flash Reprogramming Module

Sample driver for erase/program/read of QSPI flash while executing an XIP kernel out of the QSPI flash.
While communcating with the SPI flash, system will be off and the QSPI peripheral will be in SPI mode meaning no kernel functions can be called.


