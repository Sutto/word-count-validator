# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{word-count-validator}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Darcy Laycock"]
  s.date = %q{2010-09-05}
  s.description = %q{Provides validates_word_count which lets users validate a string has a minimum / maximum number of words.}
  s.email = %q{sutto@sutto.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/active_model/locale/en.yml",
     "lib/active_model/validations/word_count.rb",
     "lib/word-count-validator.rb",
     "test/helper.rb",
     "test/test_word-count-validator.rb"
  ]
  s.homepage = %q{http://github.com/Sutto/word-count-validator}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Makes validating word counts in active_model easy}
  s.test_files = [
    "test/helper.rb",
     "test/test_word-count-validator.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
