require "rails/generators"

module Ghost
  class GhostGenerator < ::Rails::Generators::NamedBase # rubocop:disable Style/Documentation
    source_root File.expand_path("templates", __dir__)

    desc "Generates a resolver in app/models/resolvers"

    def create_ghost_resolver
      template "resolver.rb", "app/models/resolvers/#{file_name}_resolver.rb"
    end

    def create_ghost_model
      template "model.rb", "app/models/#{file_name}.rb"
    end
  end
end
