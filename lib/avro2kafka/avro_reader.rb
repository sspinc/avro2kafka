require 'avro'

class Avro2Kafka
  class AvroReader
    attr_reader :io

    def initialize(io)
      @io = io
      @reader = Avro::IO::DatumReader.new()
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
