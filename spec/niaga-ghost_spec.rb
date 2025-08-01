# frozen_string_literal: true

require "spec_helper"

RSpec.describe NiagaGhost do
  after(:each) do
    User.delete_all
  end

  it "#user has valid name" do
    user = User.create!(name: "Azman")
    expect(user.name).to eq("Azman")
  end

  it "#user has a ghost accessor :contacts" do
    user = User.create!(name: "Azman")
    expect(user.contacts.count).to be == 10
  end
end
