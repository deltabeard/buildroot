################################################################################
#
# sdl_dispmanx
#
################################################################################

SDL_DISPMANX_VERSION = d983127916367c4f87592b4dab1230c5bc8ba9ac
SDL_DISPMANX_SITE = $(call github,joolswills,sdl1,$(SDL_DISPMANX_VERSION))

#SDL_DISPMANX_BUILD_OPTS += SDL_DISPMANX_INCDIR=$(STAGING_DIR)/opt/vc/include
#SDL_DISPMANX_BUILD_OPTS += SDL_DISPMANX_INCDIR=$(STAGING_DIR)/opt/vc/include/interface/vcos/pthreads
#SDL_DISPMANX_BUILD_OPTS += SDL_DISPMANX_INCDIR=$(STAGING_DIR)/opt/vc/include/interface/vmcs_host/linux

#SDL_DISPMANX_CONF_ENV += \
#CFLAGS="$(TARGET_CFLAGS) \
#	-I$(STAGING_DIR)/usr/include/ \
#	-I$(STAGING_DIR)/usr/include/interface/vcos/pthreads \
#	-I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux"

SDL_DISPMANX_DEPENDENCIES += rpi-userland
SDL_DISPMANX_CONF_ENV += INCLUDES="-I$(STAGING_DIR)/usr/include -I$(STAGING_DIR)/usr/include/interface/vcos/pthreads -I$(STAGING_DIR)/usr/include/interface/vmcs_host/linux"


SDL_DISPMANX_LICENSE = LGPLv2.1+
SDL_DISPMANX_LICENSE_FILES = COPYING
SDL_DISPMANX_INSTALL_STAGING = YES

# we're patching configure.in, but package cannot autoreconf with our version of
# autotools, so we have to do it manually instead of setting SDL_AUTORECONF = YES
define SDL_DISPMANX_RUN_AUTOGEN
	cd $(@D) && PATH=$(BR_PATH) ./autogen.sh
endef

SDL_DISPMANX_PRE_CONFIGURE_HOOKS += SDL_DISPMANX_RUN_AUTOGEN
HOST_SDL_DISPMANX_PRE_CONFIGURE_HOOKS += SDL_DISPMANX_RUN_AUTOGEN

SDL_DISPMANX_DEPENDENCIES += host-automake host-autoconf host-libtool
HOST_SDL_DISPMANX_DEPENDENCIES += host-automake host-autoconf host-libtool

# Recommended settings for sdl on pi
SDL_DISPMANX_CONF_OPTS += \
--enable-video-opengl \
--enable-video-dispmanx \
--enable-video-fbcon \
--disable-video-kms \
--disable-video-directfb \
--disable-cdrom \
--disable-oss \
--disable-alsatest \
--disable-pulseaudio \
--disable-pulseaudio-shared \
--disable-arts \
--disable-nas \
--disable-esd \
--disable-nas-shared \
--disable-diskaudio \
--disable-dummyaudio \
--disable-mintaudio \
--disable-video-x11


HOST_SDL_DISPMANX_CONF_OPTS += \
--enable-video-opengl \
--enable-video-dispmanx \
--enable-video-fbcon \
--disable-video-kms \
--disable-video-directfb \
--disable-cdrom \
--disable-oss \
--disable-alsatest \
--disable-pulseaudio \
--disable-pulseaudio-shared \
--disable-arts \
--disable-nas \
--disable-esd \
--disable-nas-shared \
--disable-diskaudio \
--disable-dummyaudio \
--disable-mintaudio \
--disable-video-x11

SDL_DISPMANX_CONFIG_SCRIPTS = sdl-config

# Remove the -Wl,-rpath option.
define SDL_DISPMANX_FIXUP_SDL_DISPMANX_CONFIG
	$(SED) 's%-Wl,-rpath,\$${libdir}%%' \
		$(STAGING_DIR)/usr/bin/sdl-config
endef

SDL_DISPMANX_POST_INSTALL_STAGING_HOOKS += SDL_DISPMANX_FIXUP_SDL_DISPMANX_CONFIG

$(eval $(autotools-package))
$(eval $(host-autotools-package))
