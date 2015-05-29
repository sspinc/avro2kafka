require 'avro2kafka/version'
require 'avro2kafka/avro_reader'
require 'avro2kafka/json_converter'
require 'avro2kafka/kafka_publisher'

class Avro2Kafka
  attr_reader :input_path, :schema_path, :kafka_broker, :kafka_topic

  def initialize(options)
    @input_path = ARGV.first
    @schema_path = options.delete(:schema)
    @kafka_broker = options.delete(:broker)
    @kafka_topic = options.delete(:topic)

    @options = options
  end

  def publish
    File.open(input_path, 'r') do |file|
      records = AvroReader.new(file, schema_path).read
      json_records = JSONConverter.new(records).convert
      KafkaPublisher.new(kafka_broker, kafka_topic).publish(json_records)
    end
    puts "Avro file published"
  end

end
