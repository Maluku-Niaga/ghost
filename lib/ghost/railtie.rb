require "rails/railtie"

module Ghost
  class Railtie < ::Rails::Railtie # rubocop:disable Style/Documentation
    initializer "ghost/active_record" do
      ActiveSupport.on_load(:active_record) do
        include Ghost
      end
    end
  end
end
