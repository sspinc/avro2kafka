require 'spec_helper'

RSpec.describe Avro2Kafka do
  describe '#publish' do
    let(:options) do
      {
        schema: './spec/support/schema.avsc',
        topic: 'kafka_topic'
      }
    end

    before do
      ARGV.replace ['./spec/support/data.avro']
    end

    it 'should output greeting text' do
      expect { Avro2Kafka.new(options).publish }.to output("Hello avro2kafka user!\n").to_stdout
    end
  end
end
