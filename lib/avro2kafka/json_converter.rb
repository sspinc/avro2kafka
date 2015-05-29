require 'json'

class Avro2Kafka
  class JSONConverter

    def initialize(records)
      @records = records
    end

    def convert
      Enumerator.new do |yielder|
        @records.each do |record|
          yielder << JSON.pretty_generate(record)
        end
      end
    end
  end
end
