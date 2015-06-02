require 'spec_helper'
require 'poseidon'

RSpec.describe Avro2Kafka::KafkaPublisher do
  describe '#publish' do
    let(:broker) { 'localhost:9092' }

    let(:topic) do
      'feeds'
    end

    let(:messages) do
      %w[message1, message2, message3]
    end

    it 'should call publisher#send_messages' do
      kafka_publisher = Avro2Kafka::KafkaPublisher.new(broker, topic)
      mock_producer = double("Producer")
      allow(kafka_publisher).to receive(:producer).and_return(mock_producer)
      expect(mock_producer).to receive(:send_messages).with(all(be_kind_of(Poseidon::MessageToSend)))
      kafka_publisher.publish(messages)
    end
  end
end
