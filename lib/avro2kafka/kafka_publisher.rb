require 'poseidon'
require 'json'

class Avro2Kafka
  class KafkaPublisher
    attr_reader :producer, :topic, :keys

    def initialize(broker, topic, keys)
      @producer = Poseidon::Producer.new([broker], "avro2kafka")
      @topic = topic
      @keys = keys.split(',').map(&:strip) if keys
    end

    def publish(records)
      records.each_slice(100) do |batch|
        messages = batch.map do |record|
          if keys
            message_key = keys.map { |key| record[key] }.join
            Poseidon::MessageToSend.new(topic, record.to_json, message_key)
          else
            Poseidon::MessageToSend.new(topic, record.to_json)
          end
        end
        producer.send_messages(messages)
      end
    end
  end
end
