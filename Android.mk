# Copyright (C) 2017 The Android Open Source Project
# Copyright (C) 2017-2018 The LineageOS Project
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

ifeq ($(call my-dir),$(call project-path-for,qcom-power))

LOCAL_PATH := $(call my-dir)

ifeq ($(call is-vendor-board-platform,QCOM),true)

include $(CLEAR_VARS)

LOCAL_MODULE_RELATIVE_PATH := hw
LOCAL_SHARED_LIBRARIES := \
    liblog \
    libcutils \
    libdl \
    libxml2 \
    libhidlbase \
    libhidltransport \
    libhardware \
    libhwbinder \
    libutils

LOCAL_SRC_FILES := \
    service.cpp \
    Power.cpp \
    power-helper.c \
    metadata-parser.c \
    utils.c \
    list.c \
    hint-data.c

LOCAL_C_INCLUDES := external/libxml2/include \
                    external/icu/icu4c/source/common

LOCAL_CFLAGS += -Wall -Wextra -Werror

ifneq ($(BOARD_POWER_CUSTOM_BOARD_LIB),)
    LOCAL_WHOLE_STATIC_LIBRARIES += $(BOARD_POWER_CUSTOM_BOARD_LIB)
else

# Include target-specific files.
ifeq ($(call is-board-platform-in-list, msm8960), true)
LOCAL_SRC_FILES += power-8960.c
endif

ifeq ($(call is-board-platform-in-list, msm8974), true)
LOCAL_SRC_FILES += power-8974.c
endif

ifeq ($(call is-board-platform-in-list, msm8226), true)
LOCAL_SRC_FILES += power-8226.c
endif

ifeq ($(call is-board-platform-in-list, msm8610), true)
LOCAL_SRC_FILES += power-8610.c
endif

ifeq ($(call is-board-platform-in-list, apq8084), true)
LOCAL_SRC_FILES += power-8084.c
endif

ifeq ($(call is-board-platform-in-list, msm8994), true)
LOCAL_SRC_FILES += power-8994.c
endif

ifeq ($(call is-board-platform-in-list, msm8992), true)
LOCAL_SRC_FILES += power-8992.c
endif

ifeq ($(call is-board-platform-in-list, msm8996), true)
LOCAL_SRC_FILES += power-8996.c
endif

ifeq ($(call is-board-platform-in-list,msm8937), true)
LOCAL_SRC_FILES += power-8937.c
endif

ifeq ($(call is-board-platform-in-list,msm8952), true)
LOCAL_SRC_FILES += power-8952.c
endif

ifeq ($(call is-board-platform-in-list,msm8953), true)
LOCAL_SRC_FILES += power-8953.c
endif

ifeq ($(call is-board-platform-in-list,msm8998 apq8098_latv), true)
LOCAL_SRC_FILES += power-8998.c
endif

ifeq ($(call is-board-platform-in-list,sdm660), true)
LOCAL_SRC_FILES += power-660.c
endif

ifeq ($(call is-board-platform-in-list,sdm845), true)
LOCAL_SRC_FILES += power-845.c
endif

ifeq ($(call is-board-platform-in-list, msm8909), true)
LOCAL_SRC_FILES += power-8909.c
endif

ifeq ($(call is-board-platform-in-list,msm8916), true)
LOCAL_SRC_FILES += power-8916.c
endif

endif  #  End of board specific list

ifneq ($(TARGET_POWER_SET_FEATURE_LIB),)
    LOCAL_STATIC_LIBRARIES += $(TARGET_POWER_SET_FEATURE_LIB)
endif

ifneq ($(TARGET_POWERHAL_SET_INTERACTIVE_EXT),)
LOCAL_CFLAGS += -DSET_INTERACTIVE_EXT
LOCAL_SRC_FILES += ../../../$(TARGET_POWERHAL_SET_INTERACTIVE_EXT)
endif

ifneq ($(TARGET_TAP_TO_WAKE_NODE),)
    LOCAL_CFLAGS += -DTAP_TO_WAKE_NODE=\"$(TARGET_TAP_TO_WAKE_NODE)\"
endif

ifeq ($(TARGET_HAS_LEGACY_POWER_STATS),true)
    LOCAL_CFLAGS += -DLEGACY_STATS
endif

ifeq ($(TARGET_HAS_NO_POWER_STATS),true)
    LOCAL_CFLAGS += -DNO_STATS
endif

ifneq ($(TARGET_RPM_STAT),)
    LOCAL_CFLAGS += -DRPM_STAT=\"$(TARGET_RPM_STAT)\"
endif

ifneq ($(TARGET_RPM_MASTER_STAT),)
    LOCAL_CFLAGS += -DRPM_MASTER_STAT=\"$(TARGET_RPM_MASTER_STAT)\"
endif

ifneq ($(TARGET_RPM_SYSTEM_STAT),)
    LOCAL_CFLAGS += -DRPM_SYSTEM_STAT=\"$(TARGET_RPM_SYSTEM_STAT)\"
endif

ifneq ($(TARGET_WLAN_POWER_STAT),)
    LOCAL_CFLAGS += -DWLAN_POWER_STAT=\"$(TARGET_WLAN_POWER_STAT)\"
endif

ifeq ($(TARGET_HAS_NO_WLAN_STATS),true)
LOCAL_CFLAGS += -DNO_WLAN_STATS
endif

ifeq ($(TARGET_ARCH),arm)
LOCAL_CFLAGS += -DARCH_ARM_32
endif

LOCAL_MODULE := android.hardware.power@1.1-service-qti
LOCAL_INIT_RC := android.hardware.power@1.1-service-qti.rc
LOCAL_SHARED_LIBRARIES += android.hardware.power@1.1 vendor.lineage.power@1.0
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_OWNER := qcom
LOCAL_VENDOR_MODULE := true
LOCAL_HEADER_LIBRARIES := libhardware_headers
include $(BUILD_EXECUTABLE)

endif

endif
