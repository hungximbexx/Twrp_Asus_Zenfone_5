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

TARGET_ARCH := x86
TARGET_ARCH_VARIANT := atom
TARGET_CPU_ABI := x86
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_ABI_LIST := x86,armeabi-v7a,armeabi
TARGET_CPU_ABI_LIST_32_BIT := x86,armeabi-v7a,armeabi
TARGET_KERNEL_CROSS_COMPILE_PREFIX := x86_64-linux-android-
TARGET_BOARD_PLATFORM := clovertrail
TARGET_BOOTLOADER_BOARD_NAME := clovertrail
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_NEEDS_PLATFORM_TEXT_RELOCATIONS := true
TARGET_OTA_ASSERT_DEVICE := T00F,T00F1,T00G,T00J,T00J1,ASUS_T00J,ASUS_T00G,ASUS_T00F,a600cg,a500cg,a501cg

# Specific headers
TARGET_BOARD_KERNEL_HEADERS := device/asus/T00F/kernel-headers

TARGET_DROIDBOOT_LIBS := libintel_droidboot

TARGET_RELEASETOOL_MAKE_RECOVERY_PATCH_SCRIPT := ./device/asus/T00F/make_recovery_patch

# OTA Packaging / Bootimg creation
BOARD_CUSTOM_MKBOOTIMG := pack_intel
BOARD_CUSTOM_BOOTIMG_MK := device/asus/T00F/mkbootimg.mk
DEVICE_BASE_BOOT_IMAGE := device/asus/T00F/base_images/boot.img
DEVICE_BASE_RECOVERY_IMAGE := device/asus/T00F/base_images/recovery.img
NEED_KERNEL_MODULE_ROOT := true

# Inline kernel building
TARGET_KERNEL_SOURCE := kernel/asus/T00F
TARGET_KERNEL_ARCH := x86
BOARD_KERNEL_IMAGE_NAME := bzImage
TARGET_KERNEL_CONFIG := lineage_T00F_defconfig
TARGET_KERNEL_CROSS_COMPILE_PREFIX := /home/nguyenhung9x/Twrp/prebuilts/gcc/linux-x86/x86/x86_64-linux-android-4.9/bin/x86_64-linux-android-

BOARD_KERNEL_CMDLINE := init=/init pci=noearly console=ttyS0 console=logk0 earlyprintk=nologger bootup.uart=0 loglevel=8 kmemleak=off androidboot.selinux=permissive androidboot.bootmedia=sdcard androidboot.hardware=redhookbay watchdog.watchdog_thresh=60 androidboot.spid=xxxx:xxxx:xxxx:xxxx:xxxx:xxxx androidboot.serialno=01234567890123456789 ip=50.0.0.2:50.0.0.1::255.255.255.0::usb0:on vmalloc=172M

TARGET_RECOVERY_UPDATER_LIBS += libosip_updater
TARGET_RECOVERY_UPDATER_EXTRA_LIBS += libintel_updater liboempartitioning_static

# Adb
BOARD_FUNCTIONFS_HAS_SS_COUNT := true

# Binder API version
TARGET_USES_64_BIT_BINDER := true

# Charger
WITH_CM_CHARGER := false
BOARD_CHARGER_ENABLE_SUSPEND := true
BOARD_HEALTHD_CUSTOM_CHARGER_RES := device/asus/T00F/charger/images

# Opengles
BOARD_EGL_CFG := device/asus/T00F/configs/egl.cfg

# Init
TARGET_INIT_VENDOR_LIB := libinit_ctp
TARGET_LIBINIT_DEFINES_FILE := device/asus/T00F/init/init_ctp.cpp
TARGET_INIT_UMOUNT_AND_FSCK_IS_UNSAFE := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 16777216
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 1677721600
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5277466624 ##5277483008 - 16384 // 5033MB
BOARD_CACHEIMAGE_PARTITION_SIZE := 519045120 # // 495MB
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1320157184 # // 1259MB
BOARD_FLASH_BLOCK_SIZE := 131072

# Recovery
BOARD_CANT_BUILD_RECOVERY_FROM_BOOT_PATCH := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
BOARD_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD
TARGET_RECOVERY_FSTAB := device/asus/T00F/recovery/root/etc/twrp.fstab
TARGET_RECOVERY_DEVICE_MODULES := libinit_ctp librecovery_updater_ctp

# TWRP
TW_THEME := portrait_hdpi
RECOVERY_GRAPHICS_USE_LINELENGTH := true
RECOVERY_SDCARD_ON_DATA := true
TW_INCLUDE_CRYPTO := true
TW_EXCLUDE_SUPERSU := true
TW_NO_USB_STORAGE := true
BOARD_HAS_NO_REAL_SDCARD := true
TW_INCLUDE_NTFS_3G := true
BOARD_SUPPRESS_EMMC_WIPE := true
RECOVERY_VARIANT := twrp

# SELinux
BOARD_SEPOLICY_DIRS += device/asus/T00F/sepolicy

#Disable Ninja
USE_NINJA := false


