require 'poseidon'

class Avro2Kafka
  class KafkaPublisher
    attr_reader :producer, :topic

    def initialize(broker, topic)
      @producer = Poseidon::Producer.new([broker], "avro2kafka")
      @topic = topic
    end

    def publish(records)
      records.each_slice(100) do |batch|
        messages = batch.map do |record|
          Poseidon::MessageToSend.new(topic, record)
        end
        producer.send_messages(messages)
      end
    end
  end
end
