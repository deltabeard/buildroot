################################################################################
#
# retroarch-assets
#
################################################################################
RETROARCH_ASSETS_VERSION = 3acffa41f215adcaa4b675055dbb4c8b19ccb74c
RETROARCH_ASSETS_SITE = $(call github,libretro,retroarch-assets,$(RETROARCH_ASSETS_VERSION))

define RETROARCH_ASSETS_INSTALL_TARGET_CMDS
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endef

$(eval $(generic-package))
