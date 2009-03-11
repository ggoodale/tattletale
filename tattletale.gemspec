# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{tattletale}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Grant Goodle"]
  s.email = %q{grant@moreblinktag.com}
  s.homepage = %q{http://github.com/ggoodale/tattletale}
  s.date = %q{2009-01-31}
  s.summary = %q{Exception logging for test environments.  Find out exactly what exceptions were thrown in your tests.}
  s.description = s.summary
   
  s.files = ["MIT-LICENSE", "Rakefile", "README", "lib/tattletale.rb", "lib/tattletale/rspec/not_raise_matcher.rb", "lib/tattletale/test/unit/tattletale_assertions.rb"]
 
  s.has_rdoc = true
  s.extra_rdoc_files = [ "README"]
  s.rdoc_options = ["--main", "README", "--inline-source", "--line-numbers"]
 
  s.test_files = ["test/rspec/rspec_matcher_test.rb", "test/unit/test_unit_assertions_test.rb"]
  s.require_path = 'lib'
end
