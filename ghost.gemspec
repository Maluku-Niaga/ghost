# frozen_string_literal: true

require_relative "lib/ghost/version"

Gem::Specification.new do |spec|
  spec.name = "niaga-ghost"
  spec.version = Ghost::VERSION
  spec.authors = ["azman abdullah"]
  spec.email = ["azmanabdlh12@gmail.com", "info@malukuniaga.com"]

  spec.summary = "Just ghost relations, plain and simple."
  spec.description = "Ghost is a minimalist Ruby DSL defining ghost associations in Rails — no ORM, just plain Ruby objects."
  spec.homepage = "https://github.com/Maluku-Niaga/ghost."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
