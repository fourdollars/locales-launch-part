PREFIX ?= /usr/local

install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	install launchers/locales-launch $(DESTDIR)$(PREFIX)/bin

uninstall:
	$(RM) $(DESTDIR)$(PREFIX)/bin/locales-launch
	-rmdir $(DESTDIR)$(PREFIX)/bin

.PHONY:
	install uninstall
