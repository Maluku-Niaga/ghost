require "rails/railtie"

module Ghost
  class Railtie < ::Rails::Railtie # rubocop:disable Style/Documentation
    initializer "ghost.extensions" do
      ActiveSupport.on_load(:active_record) do
        include Ghost
      end
    end
  end
end
