require "rails/railtie"

module NiagaGhost
  class Railtie < ::Rails::Railtie # rubocop:disable Style/Documentation
    initializer "ghost.extensions" do
      ActiveSupport.on_load(:active_record) do
        include NiagaGhost
      end
    end
  end
end
