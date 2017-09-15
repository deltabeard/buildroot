################################################################################
#
# retroarch-joypad-autoconfig
#
################################################################################
RETROARCH_JOYPAD_AUTOCONFIG_VERSION = 837e5d2ee96600433fdf206350d2126a0dd75c84
RETROARCH_JOYPAD_AUTOCONFIG_SITE = $(call github,libretro,retroarch-joypad-autoconfig,$(RETROARCH_JOYPAD_AUTOCONFIG_VERSION))

define RETROARCH_JOYPAD_AUTOCONFIG_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
