//THEOS_DEVICE_IP = 127.0.0.1 -p 2222 # install to device from pc

ARCHS = arm64
TARGET = iphone:clang:latest  # ✅ ใช้ latest SDK + iOS 14.0+
DEBUG = 0
FINALPACKAGE = 1
FOR_RELEASE = 1

# ✅ ปิด Warning ไม่ให้เป็น Error
IGNORE_WARNINGS = 1

# ✅ ไม่ต้องใช้ MOBILE_THEOS แล้ว!
# ลบ MOBILE_THEOS, SDK_PATH, SYSROOT ทิ้งทั้งหมด

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = espff

# ✅ CFLAGS — Objective-C
$(TWEAK_NAME)_CFLAGS = -fobjc-arc \
-Wall

# ✅ CCFLAGS — C++
$(TWEAK_NAME)_CCFLAGS = -std=c++17 \
-fno-rtti \
-fno-exceptions \
-DNDEBUG

# ✅ ถ้าต้องการปิด Warning ทั้งหมด
ifeq ($(IGNORE_WARNINGS),1)
  $(TWEAK_NAME)_CFLAGS += -w
  $(TWEAK_NAME)_CCFLAGS += -w
endif

# ✅ ไฟล์ Source
KITTYMEMORY_SRC = $(wildcard KittyMemory/*.cpp)
SCLALERTVIEW_SRC = $(wildcard SCLAlertView/*.m)
MENU_SRC = Menu.mm

$(TWEAK_NAME)_FILES = Tweak.xm $(MENU_SRC) $(KITTYMEMORY_SRC) $(SCLALERTVIEW_SRC) esp.mm

# ✅ Libraries
$(TWEAK_NAME)_LIBRARIES += substrate

# ✅ Frameworks
$(TWEAK_NAME)_FRAMEWORKS = \
UIKit \
Foundation \
Security \
QuartzCore \
CoreGraphics \
CoreText

# ✅ ถ้าต้องการ Rootless (iOS 15+)
# THEOS_PACKAGE_SCHEME = rootless

include $(THEOS_MAKE_PATH)/tweak.mk
