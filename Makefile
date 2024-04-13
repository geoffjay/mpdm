PROJECT := "mpdm"
PREFIX ?= /usr
DESTDIR ?=
CONFDIR = /etc
LIBDIR = /usr/lib
BINARY_NAME := "mpdm"
# Use git tag for version unless the VERSION variable is set
ifeq ($(VERSION),) 
VERSION := $(shell git describe)
endif

M = $(shell printf "\033[34;1m▶\033[0m")
TAG := $(shell git describe --all | sed -e's/.*\///g')

all: build

build: ; $(info $(M) Building project...)
	@go build -a -o target/$(BINARY_NAME) \
	    -ldflags "-X gitlab.com/geoffjay/mpdm/pkg.VERSION=$(VERSION)"

build-static: ; $(info $(M) Building static binary...)
	@CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build \
		-a -tags netgo -ldflags '-w -extldflags "-static"' \
		-o target/$(BINARY_NAME)-static

install: ; $(info $(M) Installing plantctl...)
	@install -Dm 755 target/$(BINARY_NAME) "$(DESTDIR)$(PREFIX)/bin/$(BINARY_NAME)"
	@install -Dm 644 config/mpdm.yml "$(DESTDIR)/etc/mpdm/config.yml"
	@install -Dm 644 README.md "$(DESTDIR)$(PREFIX)/share/doc/mpdm/README"
	@install -Dm 644 LICENSE "$(DESTDIR)$(PREFIX)/share/licenses/mpdm/COPYING"

uninstall:
	@rm $(DESTDIR)$(PREFIX)/bin/$(BINARY_NAME)

clean: ; $(info $(M) Removing generated files... )
	@rm -rf target/

.PHONY: all build build-static install uninstall clean
