require 'poseidon'
require 'json'

class Avro2Kafka
  class KafkaPublisher
    attr_reader :producer, :topic, :keys

    def initialize(broker, topic, key)
      @producer = Poseidon::Producer.new([broker], "avro2kafka")
      @topic = topic
      @keys = key.split(',').map { |key| key.strip }
    end

    def publish(records)
      records.each_slice(100) do |batch|
        messages = batch.map do |record|
          message_key = keys.map { |key| JSON.load(record)[key] }.join
          require 'pry'
          binding.pry
          Poseidon::MessageToSend.new(topic, record, message_key)
        end
        producer.send_messages(messages)
      end
    end
  end
end
