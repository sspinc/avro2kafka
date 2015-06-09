require 'spec_helper'
require 'avro'

RSpec.describe Avro2Kafka::AvroReader do
  describe '#read' do
    let(:path) { './spec/support/data.avro' }

    before do
      @io = File.open(path, 'r')
      @avro = Avro2Kafka::AvroReader.new(@io).read
    end

    after do
      @io.close
    end

    it 'should return an Enumerator object' do
      expect(@avro).to be_an_instance_of Enumerator
    end

    it 'should return 3 rows' do
      expect(@avro.count).to eq 3
    end

    it 'should return the correct data' do
      expect(@avro.map { |record| record }).to eq(
        [
          { 'id'=> 1, 'name'=> 'dresses',     'description'=> 'Dresses' },
          { 'id'=> 2, 'name'=> 'female-tops', 'description'=> 'Female Tops' },
          { 'id'=> 3, 'name'=> 'bras',        'description'=> 'Bras' }
        ]
      )
    end

  end
end
