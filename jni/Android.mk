LOCAL_PATH := $(call my-dir)

# Предварительно собранные статические библиотеки
include $(CLEAR_VARS)
LOCAL_MODULE    := libopenal 
LOCAL_SRC_FILES := vendor/openal/libopenal.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libopus 
LOCAL_SRC_FILES := vendor/opus/libopus.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := libenet 
LOCAL_SRC_FILES := vendor/enet/libenet.a
include $(PREBUILT_STATIC_LIBRARY)

# Основной модуль sampvoice
include $(CLEAR_VARS)

LOCAL_MODULE := sampvoice
LOCAL_LDLIBS := -llog -lOpenSLES -latomic

# Включаемые директории
LOCAL_C_INCLUDES := \
    $(LOCAL_PATH) \
    $(LOCAL_PATH)/vendor \
    $(LOCAL_PATH)/vendor/RakNet \
    $(LOCAL_PATH)/vendor/RakNet/SAMP \
    $(LOCAL_PATH)/vendor/openal \
    $(LOCAL_PATH)/vendor/opus \
    $(LOCAL_PATH)/vendor/enet \
    $(LOCAL_PATH)/vendor/imgui \
    $(LOCAL_PATH)/vendor/ini

# Список исходных файлов
FILE_LIST := \
    $(wildcard $(LOCAL_PATH)/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/*.cpp) \
    $(wildcard $(LOCAL_PATH)/clientlogic/*.cpp) \
    $(wildcard $(LOCAL_PATH)/net/*.cpp) \
    $(wildcard $(LOCAL_PATH)/util/*.cpp) \
    $(wildcard $(LOCAL_PATH)/game/RW/RenderWare.cpp) \
    $(wildcard $(LOCAL_PATH)/gui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/voice/*.cpp) \
    $(wildcard $(LOCAL_PATH)/cryptors/*.cpp) \
    $(wildcard $(LOCAL_PATH)/../santrope-tea-gtasa/encryption/*.cpp) \
    $(wildcard $(LOCAL_PATH)/../santrope-tea-gtasa/encryption/*.c)

# Файлы RakNet (явное указание для надежности)
RAKNET_SRC := \
    vendor/raknet/BitStream.cpp \
    vendor/raknet/RakClient.cpp \
    vendor/raknet/StringCompressor.cpp \
    vendor/raknet/GetTime.cpp \
    vendor/raknet/DS_Table.cpp \
    vendor/raknet/Rand.cpp \
    vendor/raknet/SHA1.cpp \
    vendor/raknet/SHA1.cpp \
    vendor/raknet/RakNetStatistics.cpp \
    vendor/raknet/RakNetworkFactory.cpp \
    vendor/raknet/SAMP/SAMP.cpp \
    vendor/raknet/SAMP/RPC.cpp

# Другие vendor-файлы
VENDOR_SRC := \
    $(wildcard $(LOCAL_PATH)/vendor/ini/*.cpp) \
    $(wildcard $(LOCAL_PATH)/vendor/imgui/*.cpp) \
    $(wildcard $(LOCAL_PATH)/vendor/hash/*.cpp)

LOCAL_SRC_FILES := $(FILE_LIST:$(LOCAL_PATH)/%=%) $(RAKNET_SRC) $(VENDOR_SRC)

# Флаги компиляции
LOCAL_CPPFLAGS := \
    -w \
    -s \
    -fvisibility=hidden \
    -pthread \
    -Wall \
    -fpack-struct=1 \
    -O2 \
    -std=c++14 \
    -fexceptions \
    -DHAVE_CONFIG_H \
    -D_RAKNET_SUPPORT_*

# Статические библиотеки
LOCAL_STATIC_LIBRARIES := libopenal libopus libenet

# Сборка shared library
include $(BUILD_SHARED_LIBRARY)
