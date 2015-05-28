require 'avro2kafka/version'

class Avro2Kafka
  attr_reader :input_path, :schema_path, :kafka_topic

  def initialize(options)
    @input_path = ARGV.first
    @schema_path = options.delete(:schema)
    @kafka_topic = options.delete(:topic)

    @options = options
  end

  def publish
    # TODO: This method is a stub
    puts "Hello avro2kafka user!"
  end

end
