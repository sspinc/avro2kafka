require 'avro2kafka/version'
require 'avro2kafka/avro_reader'
require 'avro2kafka/json_converter'
require 'avro2kafka/kafka_publisher'

class Avro2Kafka
  attr_reader :input_path, :kafka_broker, :kafka_topic, :kafka_key

  def initialize(options)
    @input_path = ARGV.first
    @kafka_broker = options.delete(:broker)
    @kafka_topic = options.delete(:topic)
    @kafka_key = options[:key]

    @options = options
  end

  def publish
    File.open(input_path, 'r') do |file|
      records = AvroReader.new(file).read
      json_records = JSONConverter.new(records).convert
      KafkaPublisher.new(kafka_broker, kafka_topic, kafka_key).publish(json_records)
    end
    puts "Avro file published to #{kafka_topic} topic on #{kafka_broker}!"
  end

end
