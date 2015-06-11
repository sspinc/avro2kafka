require 'poseidon'
require 'json'

class Avro2Kafka
  class KafkaPublisher
    attr_reader :producer, :topic, :keys, :data

    def initialize(broker_list:, topic:, keys: [], data: {})
      @producer = Poseidon::Producer.new(broker_list, 'avro2kafka')
      @topic = topic
      @keys = keys
      @data = data
    end

    def publish(records)
      records.each_slice(100) do |batch|
        messages = batch.map { |record| prepare_record(record) }
        producer.send_messages(messages)
      end
    end

    private

    def prepare_record(record)
      record = record.merge(data) if record.is_a?(Hash)
      if keys.empty?
        Poseidon::MessageToSend.new(topic, record.to_json)
      else
        message_key = keys.map { |key| record[key] }.join
        Poseidon::MessageToSend.new(topic, record.to_json, message_key)
      end
    end
  end
end
