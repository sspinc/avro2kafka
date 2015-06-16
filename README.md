# Avro2Kafka

Publish data from Avro files to Kafka in JSON format

![Travis](https://api.travis-ci.org/sspinc/avro2kafka.svg?branch=master)

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

`-b, --broker-list BROKER`
A comma-separated list of Kafka brokers, eg. localhost:9092. This value is required.

`-t, --topic TOPIC`
The Kafka topic to publish to. This value is required.

`-k, --key KEY`
A comma-separated list of fields in the avro that will act as keys for Kafka. If not supplied, unique and undefined keys will be generated, hence log compaction won't work.

`-d, --data DATA`
Extra data to pass along with the message payload. Format: key=value
Multiple arguments can be defined. For example:

    $ avro2kafka [...] -d pwd=$PWD -d site=acme

`-h, --help`
Prints help

## Contributing

1. Fork it ( https://github.com/[my-github-username]/avro2kafka/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
