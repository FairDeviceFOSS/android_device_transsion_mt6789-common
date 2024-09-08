#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter X6837 X6833B X676C X6853 S666LN CK7n,$(TARGET_DEVICE)),)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

AUDIO_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/audio.primary.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT_VENDOR)/lib/hw/audio.r_submix.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT_VENDOR)/lib64/hw/audio.primary.$(TARGET_BOARD_PLATFORM).so \
	$(TARGET_OUT_VENDOR)/lib64/hw/audio.r_submix.$(TARGET_BOARD_PLATFORM).so

$(AUDIO_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(subst $(TARGET_BOARD_PLATFORM),mediatek,$(notdir $@)) $@

DISPLAY_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/bin/hw/android.hardware.graphics.allocator@4.0-service-mediatek

$(DISPLAY_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(TARGET_BOARD_PLATFORM)/$(notdir $@).$(TARGET_BOARD_PLATFORM) $@

GATEKEEPER_TRUSTONIC_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.trustonic.so \
	$(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.trustonic.so

$(GATEKEEPER_TRUSTONIC_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf libMcGatekeeper.so $@

GATEKEEPER_DEFAULT_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/gatekeeper.default.so \
	$(TARGET_OUT_VENDOR)/lib64/hw/gatekeeper.default.so \

$(GATEKEEPER_DEFAULT_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf libSoftGatekeeper.so $@

KEYMASTER_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/lib/hw/kmsetkey.default.so \
	$(TARGET_OUT_VENDOR)/lib64/hw/kmsetkey.default.so

$(KEYMASTER_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(subst default,trustonic,$(notdir $@)) $@

MEDIA_SYMLINKS := \
	$(TARGET_OUT_VENDOR)/bin/v3avpud

$(MEDIA_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $@"
	@ln -sf $(notdir $@).$(TARGET_BOARD_PLATFORM) $@

SENSOR_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64/hw/sensors.$(TARGET_BOARD_PLATFORM).so
$(SENSOR_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $(notdir $@)"
	@ln -sf sensors.mediatek.V2.0.so $@

VENDOR_PLATFORM_SYMLINKS := $(addprefix $(TARGET_OUT_VENDOR)/, $(strip $(shell cat $(COMMON_PATH)/symlink/vendor.txt)))
$(VENDOR_PLATFORM_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	$(hide) echo "Linking $(notdir $@)"
	@ln -sf $(TARGET_BOARD_PLATFORM)/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += \
	$(AUDIO_SYMLINKS) \
	$(DISPLAY_SYMLINKS) \
	$(GATEKEEPER_TRUSTONIC_SYMLINKS) \
	$(GATEKEEPER_DEFAULT_SYMLINKS) \
	$(KEYMASTER_SYMLINKS) \
	$(MEDIA_SYMLINKS) \
	$(SENSOR_SYMLINKS) \
	$(VENDOR_PLATFORM_SYMLINKS)

endif
