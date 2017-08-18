 #
# Copyright 2013 The Android Open-Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Asus properties
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.build.asus.sku=WW

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Lights
PRODUCT_PACKAGES += \
    lights.clovertrail

# Ramdisk
PRODUCT_PACKAGES += \
    fstab.redhookbay \
    init.recovery.redhookbay.rc \
    init.recovery.usb.rc \ 
    intel_prop.cfg \
    ueventd.redhookbay.rc 

# Stlport
PRODUCT_PACKAGES += \
    libstlport

# Intel_updater
PRODUCT_PACKAGES += \
    liboempartitioning_static \
    libcgpt_static \
    libintel_updater

PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xhdpi

PRODUCT_PROPERTY_OVERRIDES += \
    ro.sf.lcd_density=320

# Ramdisk config of governors
ADDITIONAL_DEFAULT_PROPERTIES += \
    ro.sys.perf.device.powersave=800000 \
    ro.sys.perf.device.full=1633000 \
    ro.sys.perf.device.touchboost=1330000
    
    

