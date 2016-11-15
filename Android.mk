#Fork of boringssl with old api from marshmallow era
# Export SSL_CTX_ctrl for compat with gpsd blob

LOCAL_PATH := $(call my-dir)

## libcrypto


# Target shared library
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libcrypto_old
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/src/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/crypto-sources.mk
LOCAL_CFLAGS += -fvisibility=hidden -DBORINGSSL_SHARED_LIBRARY -DBORINGSSL_IMPLEMENTATION -Wno-unused-parameter
LOCAL_SDK_VERSION := 9
# sha256-armv4.S does not compile with clang.
LOCAL_CLANG_ASFLAGS_arm += -no-integrated-as
ifeq ($(TARGET_ARCH),arm64)
ifeq ($(USE_CLANG_PLATFORM_BUILD),true)
LOCAL_ASFLAGS += -march=armv8-a+crypto
endif
endif
include $(LOCAL_PATH)/crypto-sources.mk
include $(BUILD_SHARED_LIBRARY)



## libssl



# Target shared library
include $(CLEAR_VARS)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libsol
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)/src/include
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/Android.mk $(LOCAL_PATH)/ssl-sources.mk
LOCAL_CFLAGS += -fvisibility=hidden -DBORINGSSL_SHARED_LIBRARY -DBORINGSSL_IMPLEMENTATION -Wno-unused-parameter
LOCAL_SHARED_LIBRARIES=libcrypto_old
LOCAL_SDK_VERSION := 9
include $(LOCAL_PATH)/ssl-sources.mk
include $(BUILD_SHARED_LIBRARY)

