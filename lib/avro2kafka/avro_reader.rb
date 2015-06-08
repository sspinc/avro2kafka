require 'avro'

class Avro2Kafka
  class AvroReader
    attr_reader :io

    def initialize(io, schema_path)
      @io = io
      schema = Avro::Schema.parse(File.read(schema_path))
      @reader = Avro::IO::DatumReader.new(nil, schema)
    end

    def read
      records = Avro::DataFile::Reader.new(io, @reader)
      Enumerator.new do |yielder|
        records.each do |record|
          yielder << record
        end
      end
    end
  end
end
