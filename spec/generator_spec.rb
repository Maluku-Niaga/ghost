# frozen_string_literal: true

require "minitest/autorun"
require "spec_helper"

require "generators/generator"

class NiagaGhostGeneratorTest < ::Rails::Generators::TestCase
  tests NiagaGhost::NiagaGhostGenerator

  destination File.expand_path("../tmp", __dir__)
  setup :prepare_destination

  test "should generate a resolver and model" do
    run_generator(["contact"])

    assert_file("app/models/contact.rb")
    assert_file("app/models/resolvers/contact_resolver.rb")
  ensure
    FileUtils.rm_rf destination_root
  end
end
