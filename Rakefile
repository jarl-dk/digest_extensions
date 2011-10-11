# encoding: utf-8 # -*- ruby -*-

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "digest_extensions"
  gem.homepage = "http://github.com/jarl-dk/digest_extensions"
  gem.license = "GPL"
  gem.summary = "Extensions to the Digest module of the ruby standard library to support marshalling"
  gem.description = %Q{With marshalling of digest objects, it is possible to compute the digests over several executions by storing the marshalled object on file or database, this is handy for computing digests for large files that comes in parts.}
  gem.email = "jarl@softace.dk"
  gem.authors = ["Jarl Friis"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/extensiontask'
Rake::ExtensionTask.new("digest_extensions") do |ext|
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

# RSpec::Core::RakeTask.new(:rcov) do |spec|
#   spec.pattern = 'spec/**/*_spec.rb'
#   spec.rcov = true
# end

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "digest_extensions #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
