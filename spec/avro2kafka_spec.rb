require 'spec_helper'
require 'poseidon'
require 'json'

RSpec.describe Avro2Kafka do
  describe '#publish' do
    let(:options) do
      {
        broker_list: 'localhost:9092,localhost:9093',
        topic: 'feeds',
        key: 'name,id',
        data: %w[x=y alpha=omega]
      }
    end
    let(:avro2kafka) { Avro2Kafka.new(options) }

    before do
      ARGV.replace ['./spec/support/data.avro']
    end

    describe '#topic' do
      it 'returns the topic' do
        expect(avro2kafka.topic).to eq 'feeds'
      end

      it 'throws an error if topic is not present' do
        options.delete(:topic)
        expect { avro2kafka.topic }.to raise_error
      end
    end

    describe '#broker_list' do
      it 'splits the broker list by commas' do
        expect(avro2kafka.broker_list).to eq %w[localhost:9092 localhost:9093]
      end

      it 'throws an error if broker_list is not present' do
        options.delete(:broker_list)
        expect { avro2kafka.broker_list }.to raise_error
      end
    end

    describe '#extra_data' do
      it 'parses data into key-value pairs' do
        expect(avro2kafka.extra_data).to eq({ 'x' => 'y', 'alpha' => 'omega' })
      end
    end

    describe '#publish' do
      around do |ex|
        stdout_old = $stdout
        $stdout = File.open(File::NULL, 'w')
        ex.run
        $stdout = stdout_old
      end

      it 'forwards the records to KafkaPublisher#publish' do
        expect_any_instance_of(Avro2Kafka::KafkaPublisher).to receive(:publish)
        avro2kafka.publish
      end
    end
  end
end
