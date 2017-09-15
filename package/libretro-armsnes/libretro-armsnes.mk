################################################################################
#
# ARMSNES
#
################################################################################
LIBRETRO_ARMSNES_VERSION = 295da98c0fd6a371e7c3e274a60632ca4e5289a9
LIBRETRO_ARMSNES_SITE = $(call github,deltabeard,snes9x2002,$(LIBRETRO_ARMSNES_VERSION))

LIBRETRO_ARMSNES_TARGET = libretro-armsnes.so

define LIBRETRO_ARMSNES_BUILD_CMDS
	$(MAKE) CC="$(TARGET_CC)" CXX="$(TARGET_CXX)" \
		CFLAGS="$(TARGET_CFLAGS)" LD="$(TARGET_LD)" \
		TARGET="$(LIBRETRO_ARMSNES_TARGET)" -C $(@D) all
endef

define LIBRETRO_ARMSNES_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/$(LIBRETRO_ARMSNES_TARGET) \
		$(TARGET_DIR)/usr/lib/libretro/$(LIBRETRO_ARMSNES_TARGET)
endef

$(eval $(generic-package))
