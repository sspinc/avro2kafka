require 'spec_helper'
require 'json'

RSpec.describe Avro2Kafka::JSONConverter do
  describe '#convert' do
    let(:avro) do
      [
        { 'id'=> 1, 'name'=> 'dresses',     'description'=> 'Dresses' },
        { 'id'=> 2, 'name'=> 'female-tops', 'description'=> 'Female Tops' },
        { 'id'=> 3, 'name'=> 'bras',        'description'=> 'Bras' }
      ]
    end

    before do
      @json = Avro2Kafka::JSONConverter.new(avro).convert
    end

    it 'should return an Enumerator' do
      expect(@json).to be_an_instance_of Enumerator
    end

    it 'should contain the same data as the avro' do
      expect(@json.map { |json_snippet| JSON.load(json_snippet) }).to eq(avro)
    end
  end
end
