#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

COMMON_PATH := device/transsion/mt6789-common

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH) \
    hardware/transsion

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/transsion/mt6789-common/mt6789-common-vendor.mk)
