LOCAL_PATH := $(call my-dir)

RELINK := $(LOCAL_PATH)/relink.sh

#dummy file to trigger required modules
include $(CLEAR_VARS)
LOCAL_MODULE := teamwin
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin

# Manage list 
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/dump_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/flash_image
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/erase_image
RELINK_SOURCE_FILES += $(TARGET_OUT_OPTIONAL_EXECUTABLES)/busybox
RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/pigz
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/e2fsck
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/mke2fs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/tune2fs
RELINK_SOURCE_FILES += $(TARGET_OUT_EXECUTABLES)/linker
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libc.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libdl.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_blkid.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_com_err.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_e2p.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2fs.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_profile.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libext2_uuid.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/liblog.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libm.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libstdc++.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libz.so
#RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libjpeg.so
#RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libmtdutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libmmcutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libbmlutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libflashutils.so
RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libstlport.so
ifeq ($(TW_INCLUDE_BLOBPACK), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/blobpack
endif
ifeq ($(TW_INCLUDE_INJECTTWRP), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/injecttwrp
endif
ifeq ($(TW_INCLUDE_DUMLOCK), true)
    RELINK_SOURCE_FILES += $(TARGET_RECOVERY_ROOT_OUT)/sbin/htcdumlock
endif
ifeq ($(TW_INCLUDE_CRYPTO), true)
    RELINK_SOURCE_FILES += $(TARGET_OUT_SHARED_LIBRARIES)/libcrypto.so
endif


TWRP_AUTOGEN := $(intermediates)/teamwin

GEN := $(intermediates)/teamwin
$(GEN): $(RELINK)
$(GEN): $(RELINK_SOURCE_FILES) $(call intermediates-dir-for,EXECUTABLES,recovery)/recovery
	$(RELINK) $(TARGET_RECOVERY_ROOT_OUT)/sbin $(RELINK_SOURCE_FILES)
	$(RELINK) $(call intermediates-dir-for,EXECUTABLES,recovery) $(call intermediates-dir-for,EXECUTABLES,recovery)/recovery

LOCAL_GENERATED_SOURCES := $(GEN)
LOCAL_SRC_FILES := teamwin $(GEN)
include $(BUILD_PREBUILT)

#bbinstall.sh
include $(CLEAR_VARS)
LOCAL_MODULE := bbinstall.sh
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#fix_permissions
include $(CLEAR_VARS)
LOCAL_MODULE := fix_permissions.sh
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#fs
include $(CLEAR_VARS)
LOCAL_MODULE := fs
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#mke2fs.conf
include $(CLEAR_VARS)
LOCAL_MODULE := mke2fs.conf
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/etc
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#parted
include $(CLEAR_VARS)
LOCAL_MODULE := parted
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

#sdparted
include $(CLEAR_VARS)
LOCAL_MODULE := sdparted
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/sbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
include $(BUILD_PREBUILT)

ifeq ($(TW_INCLUDE_DUMLOCK), true)
	#htcdumlock for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := htcdumlocksys
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#flash_image for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := flash_imagesys
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#dump_image for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := dump_imagesys
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#libbmlutils for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := libbmlutils.so
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#libflashutils for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := libflashutils.so
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#libmmcutils for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := libmmcutils.so
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#libmtdutils for /system for dumlock
	include $(CLEAR_VARS)
	LOCAL_MODULE := libmtdutils.so
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)

	#HTCDumlock.apk
	include $(CLEAR_VARS)
	LOCAL_MODULE := HTCDumlock.apk
	LOCAL_MODULE_TAGS := eng
	LOCAL_MODULE_CLASS := RECOVERY_EXECUTABLES
	LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)/res/htcd
	LOCAL_SRC_FILES := $(LOCAL_MODULE)
	include $(BUILD_PREBUILT)
endif
