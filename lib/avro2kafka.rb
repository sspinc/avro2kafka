require 'avro2kafka/version'
require 'avro2kafka/avro_reader'
require 'avro2kafka/kafka_publisher'

require 'logr'

class Avro2Kafka
  attr_reader :options

  def self.logger
    @logger ||= Logr::Logger.new('avro2kafka')
  end

  def initialize(options)
    @path = ARGV.first
    @options = options
  end

  def reader
    ARGF.tap { |argf| argf.rewind }
  end

  def publish
    Avro2Kafka.logger.event('started_publishing', { filename: filename, topic: topic }.merge(extra_data))
                     .monitored("Started publishing #{filename}", "Started publishing #{filename} to the #{topic} Kafka topic.")
                     .info("Started publishing #{filename}")

    records = AvroReader.new(reader).read
    KafkaPublisher.new(**kafka_options).publish(records)

    Avro2Kafka.logger.event('finished_publishing', { filename: filename, topic: topic }.merge(extra_data))
                     .monitored("Finished publishing #{filename}", "Finished publishing #{filename} to the #{topic} Kafka topic.")
                     .metric('lines_processed', records.count)
                     .info("Finished publishing #{filename}")
  end

  def filename
    File.basename(@path)
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
