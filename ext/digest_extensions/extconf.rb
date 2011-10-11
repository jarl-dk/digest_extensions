# This is an extension to the ruby standard library itself, so it
# requires ruby source code to build, just the normal ruby development
# header (ruby.h) is not enough.

require "mkmf"

dir_config("ruby")

create_makefile("digest_extensions")

