require 'json'

class Avro2Kafka
  class JSONConverter

    def initialize(records)
      @records = records
    end

    def convert
      Enumerator.new do |yielder|
        @records.each do |record|
          yielder << record.to_json
        end
      end
    end
  end
end
