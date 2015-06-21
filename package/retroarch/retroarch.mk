################################################################################
#
# retroarch
#
################################################################################

RETROARCH_VERSION = 68b02ff25d47237439fa88a1cab655aec63d95c1
RETROARCH_SITE = $(call github,libretro,RetroArch,master,$(RETROARCH_VERSION))
RETROARCH_LICENSE = GPLv3+
RETROARCH_CONF_OPTS = --prefix=/usr --disable-netplay --disable-oss \
	--disable-sdl2
RETROARCH_DEPENDENCIES = host-pkgconf eudev

ifeq ($(BR2_ARM_EABIHF),y)
	RETROARCH_CONF_OPTS += --enable-floathard
endif

ifeq ($(BR2_PACKAGE_SDL2),y)
	RETROARCH_CONF_OPTS += --enable-sdl2
else
	RETROARCH_CONF_OPTS += --disable-sdl2
endif

ifeq ($(BR2_PACKAGE_SDL_DISPMANX),y)
	RETROARCH_CONF_OPTS += --enable-sdl
else
	RETROARCH_CONF_OPTS += --disable-sdl
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
	RETROARCH_CONF_OPTS += --enable-python
	RETROARCH_DEPENDENCIES += python3
else
	RETROARCH_CONF_OPTS += --disable-python
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
	RETROARCH_CONF_OPTS += --enable-x11
	RETROARCH_DEPENDENCIES += x11r7
else
	RETROARCH_CONF_OPTS += --disable-x11
endif

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
	RETROARCH_CONF_OPTS += --enable-alsa
	RETROARCH_DEPENDENCIES += alsa-lib
else
	RETROARCH_CONF_OPTS += --disable-alsa
endif

ifeq ($(BR2_PACKAGE_PULSEAUDIO),y)
	RETROARCH_CONF_OPTS += --enable-pulse
	RETROARCH_DEPENDENCIES += pulseaudio
else
	RETROARCH_CONF_OPTS += --disable-pulse
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
	RETROARCH_DEPENDENCIES += libgles
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
	RETROARCH_DEPENDENCIES += libegl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBOPENVG),y)
	RETROARCH_DEPENDENCIES += libopenvg
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
	RETROARCH_CONF_OPTS += --enable-libxml2
	RETROARCH_DEPENDENCIES += libxml2
else
	RETROARCH_CONF_OPTS += --disable-libxml2
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
	RETROARCH_CONF_OPTS += --enable-zlib
	RETROARCH_DEPENDENCIES += zlib
else
	RETROARCH_CONF_OPTS += --disable-zlib
endif

ifeq ($(BR2_PACKAGE_UDEV),y)
	RETROARCH_DEPENDENCIES += udev
endif

ifeq ($(BR2_PACKAGE_FREETYPE),y)
	RETROARCH_CONF_OPTS += --enable-freetype
	RETROARCH_DEPENDENCIES += freetype
else
	RETROARCH_CONF_OPTS += --disable-freetype
endif

define RETROARCH_CONFIGURE_FIXUP
	$(SED) 's|/opt/vc|$(STAGING_DIR)|g' $(@D)/qb/config.libs.sh
endef

RETROARCH_PRE_CONFIGURE_HOOKS += RETROARCH_CONFIGURE_FIXUP

define RETROARCH_CONFIGURE_CMDS
	(cd $(@D) ; \
		$(TARGET_CONFIGURE_OPTS) \
	        CFLAGS="$(TARGET_CFLAGS) -fgnu89-inline" \
		CXXFLAGS="$(TARGET_CXXFLAGS)" \
	        LDFLAGS="$(TARGET_LDFLAGS) -Wl,-rpath,$(STAGING_DIR)/usr/lib" \
		./configure $(RETROARCH_CONF_OPTS) \
	)
endef

define RETROARCH_BUILD_CMDS
	$(MAKE) -C $(@D) all
endef

define RETROARCH_INSTALL_TARGET_CMDS
	$(MAKE) -C $(@D) DESTDIR="$(TARGET_DIR)" install
endef

$(eval $(generic-package))

LIBRETRO_PLATFORM =
ifeq ($(BR2_ARM_CPU_ARMV6),y)
        LIBRETRO_PLATFORM += armv6
endif

ifeq ($(BR2_cortex_a7),y)
        LIBRETRO_PLATFORM += armv7
endif

ifeq ($(BR2_GCC_TARGET_FLOAT_ABI),"hard")
        LIBRETRO_PLATFORM += hardfloat
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
        LIBRETRO_PLATFORM += neon
endif

