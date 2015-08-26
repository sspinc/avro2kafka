require 'avro2kafka/version'
require 'avro2kafka/avro_reader'
require 'avro2kafka/kafka_publisher'

class Avro2Kafka
  attr_reader :options

  def initialize(options)
    @options = options
  end

  def reader
    ARGF.tap { |argf| argf.rewind }
  end

  def publish
    records = AvroReader.new(reader).read
    KafkaPublisher.new(**kafka_options).publish(records)
    $stderr.puts "Avro file published to #{topic} topic on #{broker_list}!"
  end

  def topic
    options.fetch(:topic)
  end

  def broker_list
    options.fetch(:broker_list).split(',')
  end

  def extra_data
    options.fetch(:data, []).each_with_object({}) do |data, hash|
      key, value = data.split('=')
      hash[key] = value
    end
  end

  def kafka_options
    {
      broker_list: broker_list,
      topic: topic,
      data: extra_data,
      keys: options.fetch(:key, '').split(',').map(&:strip),
    }
  end

end
