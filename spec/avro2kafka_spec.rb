require 'spec_helper'
require 'poseidon'
require 'json'

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

      # De we need to set up the Kafka instance here?

      # Get the last 3 messages from the kafka topic
      @consumer = Poseidon::PartitionConsumer.new("test_consumer", "localhost", 9092,
                                                 "feeds", 0, -3)
      Avro2Kafka.new(options).publish
    end

    it 'should output published text' do
      expect output("Avro file published to feeds topic on localhost:9092!\n").to_stdout
    end

    it 'should publish to topic' do
      messages = @consumer.fetch
      expect(messages.map { |message| JSON.parse(message.value) }).to eq(
        [
          { 'id'=> 1, 'name'=> 'dresses',     'description'=> 'Dresses' },
          { 'id'=> 2, 'name'=> 'female-tops', 'description'=> 'Female Tops' },
          { 'id'=> 3, 'name'=> 'bras',        'description'=> 'Bras' }
        ]
      )
    end
  end
end
