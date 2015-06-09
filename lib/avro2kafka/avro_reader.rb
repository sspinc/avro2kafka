require 'avro'

class Avro2Kafka
  class AvroReader
    attr_reader :io

    def initialize(io)
      @io = io
      @reader = Avro::IO::DatumReader.new()
    end

    def read
      Avro::DataFile::Reader.new(io, @reader).to_enum
    end
  end
end
