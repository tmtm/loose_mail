# frozen_string_literal: true

require_relative "lib/loose_mail/version"

Gem::Specification.new do |spec|
  spec.name          = "loose_mail"
  spec.version       = LooseMail::VERSION
  spec.authors       = ["TOMITA Masahiro"]
  spec.email         = ["tommy@tmtm.org"]
  spec.summary       = "loose_mail"
  spec.description   = "loose_mail"
  spec.homepage      = "https://github.com/tmtm/loose_mail"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tmtm/loose_mail"
  spec.metadata["changelog_uri"] = "https://github.com/tmtm/loose_mail"
  spec.files = ['LICENSE.txt', 'loose_mail.gemspec', 'lib/loose_mail.rb', 'lib/loose_mail/version.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "mail", '2.7.1'
end
