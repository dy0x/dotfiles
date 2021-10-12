#!/usr/bin/env python
import os
import sys
from ctypes import CDLL
from subprocess import call

# Morrowind
os.environ["SteamAppId"] = "22320"

# Enable Steam Overlay
os.environ["LD_PRELOAD"] = os.getenv("HOME") + "/.local/share/Steam/ubuntu12_64/gameoverlayrenderer.so"

# You can get libsteam_api.so from one of your Steam games
try:
    steam_api = CDLL("./libsteam_api.so")
    steam_api.SteamAPI_Init()
except:
    print("Failed to initialize Steam API")
    sys.exit(1)

call(["openmw"])
