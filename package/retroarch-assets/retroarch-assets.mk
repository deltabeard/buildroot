################################################################################
#
# retroarch-assets
#
################################################################################
RETROARCH_ASSETS_VERSION = 80dc7b60a5b5e7b976e005583d6c5569534e9869
RETROARCH_ASSETS_SITE = $(call github,deltabeard,retroarch-assets,$(RETROARCH_ASSETS_VERSION))

define RETROARCH_ASSETS_INSTALL_TARGET_CMDS
ifeq($(BR2_PACKAGE_RETROARCH_ASSETS_XMB_ONLY),y)
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install-xmb-monochrome
else
	$(MAKE) DESTDIR="$(TARGET_DIR)" -C $(@D) install
endif
endef

$(eval $(generic-package))
