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
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")
  spec.metadata["allowed_push_host"] = "https://github.com/tmtm/loose_mail"
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tmtm/loose_mail"
  spec.metadata["changelog_uri"] = "https://github.com/tmtm/loose_mail"
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_dependency "mail"
end
