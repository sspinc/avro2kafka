require 'spec_helper'
require 'poseidon'
require 'json'

RSpec.describe Avro2Kafka do
  describe '#publish' do
    let(:options) do
      {
        broker: 'localhost:9092',
        topic: 'feeds',
        key: 'name, id'
      }
    end

    before do
      ARGV.replace ['./spec/support/data.avro']
    end

  end
end
