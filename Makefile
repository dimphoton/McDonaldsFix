ARCHS = arm64
ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	TARGET = iphone:clang:latest:15.0
else 
	TARGET = iphone:clang:13.7:12.0
endif
INSTALL_TARGET_PROCESSES = Arch


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = McDonaldsFix

McDonaldsFix_FILES = Tweak.x
McDonaldsFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += mcdfpreferences
include $(THEOS_MAKE_PATH)/aggregate.mk