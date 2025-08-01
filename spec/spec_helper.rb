# frozen_string_literal: true

require "active_record"
require "faker"

require "niaga-ghost"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.string :name
  end
end

class Contact
  attr_accessor :id, :name, :phone_number

  def initialize(id, name, phone_number)
    @id = id
    @name = name
    @phone_number = phone_number
  end
end

class ContactResolver
  def call(model)
    generate
  end

  def generate
    collection = []

    10.times do |i|
      collection << Contact.new(i, Faker::Name.name, Faker::PhoneNumber.cell_phone)
    end

    collection
  end
end

class User < ActiveRecord::Base
  include NiagaGhost

  has_delegate :contacts
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
