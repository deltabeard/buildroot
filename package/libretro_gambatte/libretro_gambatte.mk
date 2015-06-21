################################################################################
#
# libretro-gambatte
#
################################################################################

LIBRETRO_GAMBATTE_VERSION = 36ef22b378c5f14fdd7f42adbb3920eb529a223f
LIBRETRO_GAMBATTE_SITE = $(call github,libretro,gambatte-libretro,master,$(LIBRETRO_GAMBATTE_VERSION))
LIBRETRO_GAMBATTE_DEPENDENCIES = retroarch

define LIBRETRO_GAMBATTE_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D)/libgambatte/ -f Makefile.libretro platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_GAMBATTE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/libgambatte/gambatte_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/gambatte_libretro.so
endef

$(eval $(generic-package))
