require "rake"
require 'rake/gempackagetask'
require 'rake/clean'
require 'rake/testtask'
require 'rake/rdoctask'
 
 
spec = eval(File.read("#{File.dirname(__FILE__)}/tattletale.gemspec"))
PKG_NAME = spec.name
PKG_VERSION = spec.version
 
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end
