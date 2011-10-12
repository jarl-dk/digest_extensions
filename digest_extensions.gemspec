# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{digest_extensions}
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jarl Friis"]
  s.date = %q{2011-10-11}
  s.description = %q{With marshalling of digest objects, it is possible to compute the digests over several executions by storing the marshalled object on file or database, this is handy for computing digests for large files that comes in parts.}
  s.email = %q{jarl@softace.dk}
  s.extensions = ["ext/digest_extensions/extconf.rb"]
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "digest_extensions.gemspec",
    "ext/digest_extensions/digest_extensions.c",
    "ext/digest_extensions/digest_extensions_helper.h",
    "ext/digest_extensions/extconf.rb",
    "lib/empty_dir",
    "spec/digest_extensions_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/jarl-dk/digest_extensions}
  s.licenses = ["GPL"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Extensions to the Digest module of the ruby standard library to support marshalling}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rake-compiler>, ["~> 0.7.9"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.6.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rake-compiler>, ["~> 0.7.9"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.6.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rake-compiler>, ["~> 0.7.9"])
  end
end
