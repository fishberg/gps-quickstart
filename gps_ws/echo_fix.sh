#!/usr/bin/env bash
ros2 topic echo /ublox_gps_node/navpvt | \
python3 -u -c '
import sys, re
for line in sys.stdin:
    m = re.search(r"flags:\s*(\d+)", line)
    if m:
        flags = int(m.group(1))
        rtk_float = 1 if ((flags >> 6) & 0b11) == 1 else 0
        rtk_fix = 1 if ((flags >> 6) & 0b11) == 2 else 0
        print(f"FLAGS={flags}    RTK_FLOAT={rtk_float}    RTK_FIX={rtk_fix}", flush=True)
'

#ros2 topic echo /ublox_gps_node/navpvt
# "flags" bits 6-7:
# 0b00 = 0 = No carrier solution
# 0b01 = 1 = RTK Float
# 0b10 = 2 = RTK Fixed
