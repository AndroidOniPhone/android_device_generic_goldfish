#
# Copyright (C) 2018 The Android Open Source Project
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
# This file is to configure vendor/data partitions of emulator-related products
#
$(call inherit-product-if-exists, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

ifeq ($(QEMU_DISABLE_AVB),true)
  ifeq ($(QEMU_USE_SYSTEM_EXT_PARTITIONS),true)
    PRODUCT_COPY_FILES += \
      device/generic/goldfish/data/etc/dummy.vbmeta.img:$(PRODUCT_OUT)/vbmeta.img \
      device/generic/goldfish/fstab.ranchu.initrd.noavb.ex:$(TARGET_COPY_OUT_RAMDISK)/fstab.ranchu \
      device/generic/goldfish/fstab.ranchu.noavb.ex:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ranchu
  else
    PRODUCT_COPY_FILES += \
      device/generic/goldfish/data/etc/dummy.vbmeta.img:$(PRODUCT_OUT)/vbmeta.img \
      device/generic/goldfish/fstab.ranchu.initrd.noavb:$(TARGET_COPY_OUT_RAMDISK)/fstab.ranchu \
      device/generic/goldfish/fstab.ranchu.noavb:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ranchu
  endif
endif

PRODUCT_SYSTEM_EXT_PROPERTIES += ro.lockscreen.disable.default=1
ifeq ($(QEMU_USE_SYSTEM_EXT_PARTITIONS),true)
PRODUCT_COPY_FILES += \
    device/generic/goldfish/fstab.ranchu.initrd.ex:$(TARGET_COPY_OUT_RAMDISK)/fstab.ranchu \
    device/generic/goldfish/fstab.ranchu.ex:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ranchu
endif


DISABLE_RILD_OEM_HOOK := true

DEVICE_MANIFEST_FILE := device/generic/goldfish/manifest.xml

# Device modules
PRODUCT_PACKAGES += \
    vulkan.ranchu \
    libandroidemu \
    libOpenglCodecCommon \
    libOpenglSystemCommon \
    libEGL_swiftshader \
    libGLESv1_CM_swiftshader \
    libGLESv2_swiftshader \
    libgoldfish-ril \
    qemu-props \
    gps.goldfish \
    gps.ranchu \
    fingerprint.goldfish \
    audio.primary.goldfish \
    audio.primary.goldfish_legacy \
    power.goldfish \
    stagefright \
    power.ranchu \
    fingerprint.ranchu \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.allocator@3.0-service \
    android.hardware.graphics.mapper@3.0-impl-ranchu \
    hwcomposer.ranchu \
    toybox_vendor \
    android.hardware.audio@2.0-service \
    android.hardware.wifi@1.0-service \
    android.hardware.biometrics.fingerprint@2.1-service \
    sh_vendor \
    ip_vendor \
    iw_vendor \
    audio.r_submix.default \
    local_time.default \
    SdkSetup \
    libstagefrighthw \
    libstagefright_goldfish_vpxdec \
    libstagefright_goldfish_avcdec \
    MultiDisplayProvider

ifneq ($(BUILD_EMULATOR_OPENGL),false)
PRODUCT_PACKAGES += \
    libGLESv1_CM_emulation \
    lib_renderControl_enc \
    libEGL_emulation \
    libGLESv2_enc \
    libvulkan_enc \
    libGLESv2_emulation \
    libGLESv1_enc
endif

PRODUCT_PACKAGES += \
    android.hardware.audio@5.0-impl:32 \
    android.hardware.audio.effect@5.0-impl:32 \
    android.hardware.broadcastradio@1.1-service \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl

PRODUCT_PACKAGES += \
    android.hardware.health@2.0-service

PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0-impl \
    android.hardware.keymaster@4.0-service

PRODUCT_PACKAGES += \
    DisplayCutoutEmulationEmu01Overlay

ifneq ($(EMULATOR_VENDOR_NO_GNSS),true)
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-service \
    android.hardware.gnss@1.0-impl
DEVICE_MANIFEST_FILE += device/generic/goldfish/manifest.gnss.xml
endif

ifneq ($(EMULATOR_VENDOR_NO_SENSORS),true)
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl \
    android.hardware.sensors@1.0-service \
    sensors.ranchu
DEVICE_MANIFEST_FILE += device/generic/goldfish/manifest.sensors.xml
endif

PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.2-service.clearkey \
    android.hardware.drm@1.2-service.widevine

PRODUCT_PACKAGES += \
    android.hardware.power@1.1-service.ranchu \

PRODUCT_PROPERTY_OVERRIDES += ro.control_privapp_permissions=enforce
PRODUCT_PROPERTY_OVERRIDES += ro.hardware.power=ranchu
PRODUCT_PROPERTY_OVERRIDES += ro.crypto.volume.filenames_mode=aes-256-cts

PRODUCT_PROPERTY_OVERRIDES += persist.sys.zram_enabled=1 \

ifneq ($(EMULATOR_VENDOR_NO_CAMERA),true)
PRODUCT_PACKAGES += \
    camera.device@1.0-impl \
    android.hardware.camera.provider@2.4-service \
    android.hardware.camera.provider@2.4-impl \
    camera.goldfish \
    camera.goldfish.jpeg \
    camera.ranchu \
    camera.ranchu.jpeg
DEVICE_MANIFEST_FILE += device/generic/goldfish/manifest.camera.xml
endif

PRODUCT_PACKAGES += \
    android.hardware.gatekeeper@1.0-service.software

# WiFi: vendor side
PRODUCT_PACKAGES += \
	createns \
	dhcpclient \
	execns \
	hostapd \
	hostapd_nohidl \
	netmgr \
	wifi_forwarder \
	wpa_supplicant \

# Thermal
PRODUCT_PACKAGES += \
	android.hardware.thermal@2.0-service.mock

# Atrace
PRODUCT_PACKAGES += \
	android.hardware.atrace@1.0-service

# Vibrator
PRODUCT_PACKAGES += \
	android.hardware.vibrator-service.example

# Authsecret
PRODUCT_PACKAGES += \
    android.hardware.authsecret@1.0-service

# Input Classifier HAL
PRODUCT_PACKAGES += \
    android.hardware.input.classifier@1.0-service.default

# power stats
PRODUCT_PACKAGES += \
    android.hardware.power.stats@1.0-service.mock

# Goldfish does not support ION needed for Codec 2.0
PRODUCT_PROPERTY_OVERRIDES += \
    debug.stagefright.ccodec=0

PRODUCT_COPY_FILES += \
    device/generic/goldfish/fstab.ranchu.initrd:$(TARGET_COPY_OUT_RAMDISK)/fstab.ranchu \
    device/generic/goldfish/data/etc/apns-conf.xml:data/misc/apns/apns-conf.xml \
    device/generic/goldfish/data/etc/local.prop:data/local.prop \
    device/generic/goldfish/init.ranchu-core.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.ranchu-core.sh \
    device/generic/goldfish/init.ranchu-net.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.ranchu-net.sh \
    device/generic/goldfish/wifi/init.wifi.sh:$(TARGET_COPY_OUT_VENDOR)/bin/init.wifi.sh \
    device/generic/goldfish/init.ranchu.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.ranchu.rc \
    device/generic/goldfish/fstab.ranchu:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.ranchu \
    device/generic/goldfish/ueventd.ranchu.rc:$(TARGET_COPY_OUT_VENDOR)/ueventd.rc \
    device/generic/goldfish/input/goldfish_rotary.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/goldfish_rotary.idc \
    device/generic/goldfish/input/qwerty2.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/qwerty2.idc \
    device/generic/goldfish/input/qwerty.kl:$(TARGET_COPY_OUT_VENDOR)/usr/keylayout/qwerty.kl \
    device/generic/goldfish/input/virtio_input_multi_touch_1.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_1.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_2.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_2.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_3.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_3.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_4.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_4.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_5.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_5.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_6.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_6.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_7.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_7.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_8.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_8.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_9.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_9.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_10.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_10.idc \
    device/generic/goldfish/input/virtio_input_multi_touch_11.idc:$(TARGET_COPY_OUT_VENDOR)/usr/idc/virtio_input_multi_touch_11.idc \
    device/generic/goldfish/data/etc/config.ini:config.ini \
    device/generic/goldfish/wifi/simulated_hostapd.conf:$(TARGET_COPY_OUT_VENDOR)/etc/simulated_hostapd.conf \
    device/generic/goldfish/wifi/wpa_supplicant.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant.conf \
    device/generic/goldfish/wifi/WifiConfigStore.xml:data/misc/wifi/WifiConfigStore.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.wifi.direct.xml \
    device/generic/goldfish/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml \
    device/generic/goldfish/camera/media_profiles.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_profiles_V1_0.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_telephony.xml \
    device/generic/goldfish/camera/media_codecs_google_video_default.xml:${TARGET_COPY_OUT_VENDOR}/etc/media_codecs_google_video.xml \
    device/generic/goldfish/camera/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml \
    device/generic/goldfish/camera/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.camera.ar.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.ar.xml \
    frameworks/native/data/etc/android.hardware.camera.autofocus.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.full.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.camera.full.xml \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.vulkan.level-1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.level.xml \
    frameworks/native/data/etc/android.hardware.vulkan.compute-0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.compute.xml \
    frameworks/native/data/etc/android.hardware.vulkan.version-1_1.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.vulkan.version.xml \
    device/generic/goldfish/data/etc/android.software.vulkan.deqp.level-2019-03-01.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.vulkan.deqp.level-2019-03-01.xml \
    frameworks/native/data/etc/android.software.autofill.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.software.autofill.xml \
    frameworks/native/data/etc/android.software.verified_boot.xml:${TARGET_COPY_OUT_PRODUCT}/etc/permissions/android.software.verified_boot.xml \
    frameworks/av/media/libeffects/data/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    device/generic/goldfish/audio_policy.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy.conf \
    frameworks/av/services/audiopolicy/config/audio_policy_configuration_generic.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/primary_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/primary_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:$(TARGET_COPY_OUT_VENDOR)/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/surround_sound_configuration_5_0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/surround_sound_configuration_5_0.xml \
    device/generic/goldfish/data/etc/permissions/privapp-permissions-goldfish.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/privapp-permissions-goldfish.xml
