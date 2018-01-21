################################################################################
#
# libretro-samples
#
################################################################################

LIBRETRO_SAMPLES_VERSION = 5a56c6b5a0490647c4594a1bcd634b6bb377aca8
LIBRETRO_SAMPLES_SITE = $(call github,libretro,libretro-samples,$(LIBRETRO_SAMPLES_VERSION))
LIBRETRO_SAMPLES_DEPENDENCIES = retroarch

define LIBRETRO_SAMPLES_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" $(MAKE) CC="$(TARGET_CC)" \
		   -C $(@D)/video/opengl/libretro_test_gl_shaders \
		   platform="$(LIBRETRO_PLATFORM)"
endef

define LIBRETRO_SAMPLES_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/video/opengl/libretro_test_gl_shaders/testgl_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/testgl_libretro.so
endef

$(eval $(generic-package))
