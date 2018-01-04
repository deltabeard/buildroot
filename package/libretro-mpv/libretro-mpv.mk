################################################################################
#
# libretro-mpv
#
################################################################################

LIBRETRO_MPV_VERSION = 0.2.alpha
LIBRETRO_MPV_SITE = https://github.com/deltabeard/libretro-mpv/archive
LIBRETRO_MPV_SOURCE = $(LIBRETRO_MPV_VERSION).tar.gz
LIBRETRO_MPV_DEPENDENCIES = mpv retroarch

define LIBRETRO_MPV_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" $(MAKE) CC="$(TARGET_CC)" -C $(@D) \
		   platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_MPV_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mpv_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mpv_libretro.so
endef

$(eval $(generic-package))
