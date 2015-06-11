require 'spec_helper'
require 'poseidon'

RSpec.describe Avro2Kafka::KafkaPublisher do
  describe '#publish' do
    let(:broker_list) { %w[localhost:9092] }
    let(:topic) { 'feeds' }
    let(:keys) { %w[name id] }
    let(:data) { {'site' => 'acme' } }
    let(:messages) { [{ 'id' => 1, 'name' => 'dresses' }, { 'id' => 2, 'name' => 'tops' }] }
    let(:publisher) { Avro2Kafka::KafkaPublisher.new(broker_list: broker_list, topic: topic, keys: keys, data: data) }
    let(:producer) { double('producer') }

    before do
      allow(publisher).to receive(:producer).and_return(producer)
    end

    it 'should call publisher#send_messages' do
      expect(producer).to receive(:send_messages).with(all(be_kind_of(Poseidon::MessageToSend)))
      publisher.publish(messages)
    end

    it 'should create keys' do
      expect(producer).to receive(:send_messages) do |args|
        expect(args).to all(have_attributes(key: a_value))
      end

      publisher.publish(messages)
    end

    it 'should add extra data to payload' do
      expect(producer).to receive(:send_messages) do |args|
        expect(args.map { |a| JSON.load(a.value) }).to all(include({ 'site' => 'acme' }))
      end

      publisher.publish(messages)
    end
  end
end
