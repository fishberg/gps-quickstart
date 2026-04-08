# GPS Quickstart

---

## Bill of Materials

### GNSS Receiver Module
| Purpose | Vendor | Item | Cost | Link |
| - | - | - | - | - |
| GNSS Receiver Module (F9P) | Sparkfun | SparkFun GPS-RTK-SMA Breakout - ZED-F9P (Qwiic) | $259.95 | [Link](https://www.sparkfun.com/sparkfun-gps-rtk-sma-breakout-zed-f9p-qwiic.html#) |
| Antenna (UFO / Base Station) | Sparkfun | GNSS Multi-Band L1/L2/L5 Surveying Antenna - TNC (SPK6618H) | $169.95 | [Link](https://www.sparkfun.com/gnss-multi-band-l1-l2-l5-surveying-antenna-tnc-spk6618h.html) |
| Ground Plate | Sparkfun | GPS Antenna Ground Plate | $7.25 | [Link](https://www.sparkfun.com/gps-antenna-ground-plate.html) |
| Antenna (Rover) | Mouser | AS-ANT2B-ANN-L1L2-50SMA-00 | $64.98 | [Link](https://www.mouser.com/ProductDetail/ArduSimple/AS-ANT2B-ANN-L1L2-50SMA-00?qs=sPbYRqrBIVkv%252Bc79%2Ft3W8w%3D%3D) |
| GNSS Receiver Module (F9P) + Antenna (Helical) | Holybro | H-RTK F9P GNSS Series (IST8310 Compass) | $296.99 | [Link](https://holybro.com/products/h-rtk-f9p-gnss-series?variant=41466787168445) |

---

## Software

### u-center
- [u-center](https://www.u-blox.com/en/product/u-center)
  - Do **not** use `u-center2`
  - If you get an error message about `VCRUNTIME140.dll`, you should install `vc_redist.x86.exe` and `vc_redist.x64.exe` from [this link](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist).

### RTKLib
- RTKLib (Original)
  - [Website](https://www.rtklib.com/)
  - [Source](https://github.com/tomojitakasu/RTKLIB)
  - [Binaries (Windows)](https://github.com/tomojitakasu/RTKLIB_bin/tree/rtklib_2.4.3)
- RTKLib (Updated Fork)
  - [Source](https://github.com/rtklibexplorer/RTKLIB)
  - [Binaries (Windows)](https://github.com/rtklibexplorer/RTKLIB/releases)

### ROS2 Code
- [ntrip_client](https://github.com/LORD-MicroStrain/ntrip_client)
- [ublox](https://github.com/KumarRobotics/ublox)

---

## References
- [Sparkfun Guide:  Setting up a Rover Base RTK System](https://learn.sparkfun.com/tutorials/setting-up-a-rover-base-rtk-system/all)
- [Sparkfun Guide: How to Build a DIY GNSS Reference Station ](https://learn.sparkfun.com/tutorials/how-to-build-a-diy-gnss-reference-station)

---

## Config RTK Base Station

### Firmware Update
- Check Firmware Version
	- `View > Message View`
	- `UBX > MON > VER`
	- `FWVER= HPG 1.51`
- Download F9P firmware update [here](https://www.u-blox.com/en/product/zed-f9p-module?legacy=Current#Documentation-&-resources) (1.51, released 24-Nov-2024 at ToW)

### Enable RTCM
- `F9 > UBX > CFG > MSG (Messages)`
- Enable for `USB`, and click `Send`
  - `RTCM3.3 1005`
  - `RTCM3.3 1074`
  - `RTCM3.3 1084`
  - `RTCM3.3 1094`
  - `RTCM3.3 1124`
  - `RTCM3.3 1230` x 5 (Enable message every 5 seconds)

### Save Settings
- `F9 > UBX > CFG > CFG`
- `Save current configuration`
- Devices
  - `0 - BRB` :: Records seetings to "Battery Backed RAM" -- i.e., maintains settings for over a week
  - `1 - FLASH` :: Records settings to the "Flash Memory", also known as "non-volatile memory (NVM)" -- i.e., maintains settings through power and battery lose
 
### Enable Survey Mode
- `F9 > UBX > CFG > TMODE3`
  - Mode: `1 - Survey-in`
  - Minimum Observation Time: `60`
  - Require Position Accuracy: `5.0`

### View Survey In Message
- `F9 > UBX > NAV > SVIN (Survey-in)`
	- Right Click (Enable Message)

---

## Config NTRIP Caster
- `strsvr.exe`
  - Port: `2101`
  - Mountpoint: `u-blox`
  - User ID: `test`
  - Password: `test`

---

## Build NTRIP Caster on Linux
```
sudo apt install -y git build-essential cmake libblas-dev liblapack-dev qtchooser qt6-base-dev qt6-serialport-dev
git clone https://github.com/rtklibexplorer/RTKLIB.git
cd RTKLIB
mkdir build
cd build
cmake ..
make -j
cd ../bin
./strsvr_qt
```
- Instructions adapted from [here](https://github.com/rtklibexplorer/RTKLIB)


---

## RTK2go
- [Pennovation](http://rtk2go.com:2101/SNIP::MOUNTPT?baseName=Pennovation)
