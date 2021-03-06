################################################################################
#
# MGBA
#
################################################################################
LIBRETRO_MGBA_VERSION = abf5a1889f34f9639e484bfd7a8f4a1e636de529
LIBRETRO_MGBA_SITE = $(call github,libretro,mgba,$(LIBRETRO_MGBA_VERSION))

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
	LIBRETRO_MGBA_NEON += "HAVE_NEON=1"
else
	LIBRETRO_MGBA_NEON += "HAVE_NEON=0"
endif

define LIBRETRO_MGBA_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) \
		   CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/ \
		   -f Makefile.libretro platform="$(LIBRETRO_PLATFORM)" $(LIBRETRO_MGBA_NEON)
endef

define LIBRETRO_MGBA_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/mgba_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/mgba_libretro.so
endef

$(eval $(generic-package))
