################################################################################
#
# snes9x2002
#
################################################################################
LIBRETRO_SNES9X2002_VERSION = 5faae30dfaee1a79b9cbf4c2a79b3845d853d17b
LIBRETRO_SNES9X2002_SITE = $(call github,deltabeard,snes9x2002,$(LIBRETRO_SNES9X2002_VERSION))

define LIBRETRO_SNES9X2002_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" LD="$(TARGET_LD)" \
		$(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) \
		platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_SNES9X2002_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/snes9x2002_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/snes9x2002_arm_libretro.so
endef

$(eval $(generic-package))
