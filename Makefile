SHELL=/bin/bash
LINK_FLAGS = --link-flags "-static -lxml2 -llzma -lz -lm"
# BUILD_FLAGS = --release

.PHONY : static
static: src/bin/cli.cr
	crystal build ${BUILD_FLAGS} $^ -o xq ${LINK_FLAGS}

.PHONY : test
test: spec

.PHONY : spec
spec: static
	crystal spec -v --fail-fast

.PHONY : release
release: static
	@github-release
	@./bin/release
