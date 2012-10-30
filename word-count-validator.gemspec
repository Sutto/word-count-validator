# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name = %q{word-count-validator}
  s.version = "0.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Darcy Laycock", "Eric Anderson"]
  s.date = %q{2010-12-11}
  s.description = %q{Provides validates_word_count which lets users validate a string has a minimum / maximum number of words.}
  s.email = %q{sutto@sutto.net}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = `git ls-files`.split("\n") + %w(LICENSE README.rdoc)
  s.homepage = %q{http://github.com/Sutto/word-count-validator}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Makes validating word counts in active_model easy}
  s.test_files = Dir.glob('spec/**/*')

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end

  s.add_development_dependency "rspec", ">=2"
  s.add_development_dependency "bundler"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "rails"
  s.add_development_dependency "jeweler"
end

