include ../../Makefile.include QT5-VERSION
DEPS = ../../Makefile.include QT5-VERSION Makefile

# INFO
#  make -C target qt5
# ./target/qt5/arm-webos-linux-gnueabi-release/configure -help | less

CONFIGURE=./configure \
	-prefix $(PREFIX) \
	-libdir $(PREFIX)/lib \
	-static \
	-L $(PREFIX)/lib \
	-opensource \
	-confirm-license \
	-nomake tests \
	-nomake examples \
	-no-widgets \
	-device linux-arm-generic-g++ \
	-device-option CROSS_COMPILE=$(TOOLCHAIN)/bin/arm-webos-linux-gnueabi- \
	-device-option DISTRO_OPTS="" \
	-verbose \
	"QMAKE_CFLAGS += $(CFLAGS)" \
	"QMAKE_CXXFLAGS += $(CXXFLAGS)"

#	-sysroot $(TOOLCHAIN)/$(HOST)/sysroot \
#	-gcc-sysroot \
#	"QMAKE_LIBS_WAYLAND_EGL = $(PREFIX)/lib/libwayland-egl.a" \
#	"QMAKE_LIBS_WAYLAND_CLIENT = $(PREFIX)/lib/libwayland-client.a" \
#	"QMAKE_LIBS_WAYLAND_CURSOR = $(PREFIX)/lib/libwayland-cursor.a"


BUILDDIR=$(PLATFORM)/shadow

all: .installed-$(PLATFORM)

init: $(PLATFORM)/init-repository

download:

$(PLATFORM)/init-repository:
	mkdir -p $(PLATFORM)
	cd $(PLATFORM); \
		git clone $(BASE_URL).git -b v$(VERSION) .; \
		./init-repository --module-subset=qtbase,qtwayland; \
		cd qtbase; \
		git apply ../../qtbase-gcc-limits.patch;

$(BUILDDIR)/config.cache: $(DEPS) | $(PLATFORM)/init-repository
	mkdir -p $(BUILDDIR);
	cd $(BUILDDIR); ../$(CONFIGURE)

$(BUILDDIR)/.built: $(BUILDDIR)/config.cache
	$(MAKE) -C $(BUILDDIR)
	touch $@

.installed-$(PLATFORM): $(BUILDDIR)/.built
	$(MAKE) -C $(BUILDDIR) install
	touch $@

clean:
	$(MAKE) -C $(BUILDDIR) clean
	$(MAKE) -C $(BUILDDIR)/qtbase clean || true
	rm -f .installed-$(PLATFORM)

confclean:
	rm -rf $(BUILDDIR)/qtwayland \
		   $(BUILDDIR)/qtbase/doc \
		   $(BUILDDIR)/qtbase/include \
		   $(BUILDDIR)/qtbase/lib \
		   $(BUILDDIR)/qtbase/mkspecs \
		   $(BUILDDIR)/qtbase/plugins \
		   $(BUILDDIR)/qtbase/src \
		   $(BUILDDIR)/.config.notes \
		   $(BUILDDIR)/config.* \
		   $(BUILDDIR)/Makefile \
		   $(BUILDDIR)/.built

distclean:
	rm -rf $(PLATFORM) .installed-$(PLATFORM)
