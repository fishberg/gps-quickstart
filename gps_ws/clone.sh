#!/usr/bin/env bash
mkdir -p src
cd src

# ntrip_client
git clone -b ros2 https://github.com/LORD-MicroStrain/ntrip_client.git

# ublox
git clone -b ros2 https://github.com/KumarRobotics/ublox.git
