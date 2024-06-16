ARCHS = arm64 arm64e
ifeq ($(THEOS_PACKAGE_SCHEME),rootless)
	TARGET = iphone:clang:16.5:15.0
else 
	TARGET = iphone:clang:13.7:12.0
endif

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = MCDFPreferences

MCDFPreferences_FILES = MCDFPRootListController.m
MCDFPreferences_FRAMEWORKS = Foundation UIKit
MCDFPreferences_PRIVATE_FRAMEWORKS = Preferences
MCDFPreferences_INSTALL_PATH = /Library/PreferenceBundles
MCDFPreferences_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk