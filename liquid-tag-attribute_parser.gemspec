# frozen_string_literal: true

require_relative "lib/liquid/tag/attribute_parser/version"

Gem::Specification.new do |spec|
  spec.name          = "liquid-tag-attribute_parser"
  spec.version       = Liquid::Tag::AttributeParser::VERSION
  spec.authors       = ["Unai Abrisketa"]
  spec.email         = ["github@unaiabrisketa.com"]

  spec.summary       = "Easily parse liquid tags"
  spec.description   = "Send html-like attributes along with your Liquid tag and parse them to get a hash back"
  spec.homepage      = "https://github.com/unabris/liquid-tag-attribute_parser"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.5.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/unabris/liquid-tag-attribute_parser"
  spec.metadata["changelog_uri"] = "https://github.com/unabris/liquid-tag-attribute_parser/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("liquid", ">= 3.0")

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
