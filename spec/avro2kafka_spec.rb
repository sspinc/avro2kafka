require 'spec_helper'

RSpec.describe Avro2Kafka do
  describe '#publish' do
    let(:options) do
      {
        schema: './spec/support/schema.avsc',
        broker: 'localhost:9092',
        topic: 'feeds'
      }
    end

    before do
      ARGV.replace ['./spec/support/data.avro']
    end

    it 'should output published text' do
      expect { Avro2Kafka.new(options).publish }.to output("Avro file published\n").to_stdout
    end
  end
end
