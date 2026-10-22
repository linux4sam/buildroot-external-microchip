################################################################################
#
# lohit fonts
#
################################################################################

# The upstream releases.pagure.org tarballs are no longer available, so build
# from the upstream git repository. This revision matches the
# lohit-ttf-20140220 release (Lohit-Devanagari 2.94.0).
LOHIT_FONTS_VERSION = 18c9c58c78029e6568c2e570f29e089201af5903
LOHIT_FONTS_SITE = https://github.com/pravins/lohit.git
LOHIT_FONTS_SITE_METHOD = git

LOHIT_FONTS_LICENSE = OFL-1.1
LOHIT_FONTS_LICENSE_FILES = OFL.txt

LOHIT_FONTS_DEPENDENCIES = host-fontforge

LOHIT_FONTS_FONTS = \
	$(call qstrip,$(BR2_PACKAGE_LOHIT_FONTS_FONTS))

# The repository only carries font sources, so generate the TTFs with
# fontforge, applying the feature file of the font when there is one.
# Newer fontforge rejects comma separated lookupflags in the feature file.
# fontforge only warns on feature file errors, so make sure the OpenType
# layout tables actually made it into the font.
define LOHIT_FONTS_BUILD_CMDS
	$(foreach f,$(LOHIT_FONTS_FONTS), \
		sfd=`ls $(@D)/$(f)/*.sfd` || exit 1; \
		fea=$${sfd%.sfd}.fea; \
		ttf=$${sfd%.sfd}.ttf; \
		if [ -f $$fea ]; then \
			sed -e '/lookupflag/ s/,/ /g' $$fea > $${fea}.fixed || exit 1; \
			fea=$${fea}.fixed; \
		else \
			fea=; \
		fi; \
		$(HOST_DIR)/bin/fontforge -lang=py -script \
			$(LOHIT_FONTS_PKGDIR)/generate-ttf.py $$sfd $$ttf $$fea || exit 1; \
		if ! grep -q -a GSUB $$ttf; then \
			echo "$$ttf was generated without OpenType GSUB tables"; \
			exit 1; \
		fi$(sep))
endef

define LOHIT_FONTS_INSTALL_TARGET_CMDS
	$(foreach f,$(LOHIT_FONTS_FONTS), \
		$(INSTALL) -D -m 0644 -t $(TARGET_DIR)/usr/share/fonts/truetype/lohit-$(f) \
			$(@D)/$(f)/*.ttf$(sep))
endef

$(eval $(generic-package))
