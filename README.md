# Avro2Kafka

Publish data from Avro files to Kafka in JSON format

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'avro2kafka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install avro2kafka

## Usage

```
Usage: avro2kafka [options] [file]
```

### Options

`-b, --broker BROKER`
The Kafka broker, eg. localhost:9092. This value is required.

`-t, --topic TOPIC`
The Kafka topic to publish to. This value is required.

`-k, --key KEY`
The fields in the avro that will act as keys for Kafka. If not supplied, messages will not be partioned, hence log compaction won't work.

`-h, --help`
Prints help

## Contributing

1. Fork it ( https://github.com/[my-github-username]/avro2kafka/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
