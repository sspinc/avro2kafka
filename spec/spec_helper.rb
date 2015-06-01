require 'avro2kafka'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each {|f| require f }

# RSpec.configure do |config|
#   config.after(:all) do
#     Dir["./spec/support/*.avro", "./spec/support/*.bad*"].each do |file|
#       File.delete(file)
#     end
#   end
# end
