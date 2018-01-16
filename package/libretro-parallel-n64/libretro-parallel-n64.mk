################################################################################
#
# PARALLEL-N64
#
################################################################################
LIBRETRO_PARALLEL_N64_VERSION = 8c7466029074c9a465fd47dcea812fed7e4d49d3
LIBRETRO_PARALLEL_N64_SITE = git://github.com/libretro/parallel-n64.git
LIBRETRO_PARALLEL_N64_GIT_SUBMODULES = YES

define LIBRETRO_PARALLEL_N64_BUILD_CMDS
	CFLAGS="$(TARGET_CFLAGS)" CXXFLAGS="$(TARGET_CXXFLAGS)" $(MAKE) \
		   CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" -C $(@D) \
		   platform="$(LIBRETRO_PLATFORM)" WITH_DYNAREC=arm
endef

define LIBRETRO_PARALLEL_N64_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/parallel_n64_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/parallel_n64_libretro.so
endef

$(eval $(generic-package))
