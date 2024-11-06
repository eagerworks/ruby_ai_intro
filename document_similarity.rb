require 'neighbor'
require 'openai'
OpenAI.configure do |config|
  config.access_token = ENV.fetch('OPENAI_API_KEY')
  config.log_errors = true
end
require_relative 'shared/embedder'
require_relative 'shared/migrations'
require_relative 'shared/models'
require_relative 'shared/seeds'
require_relative 'shared/colorize'

# Document similarity
document = Document.first
puts "Input document: \n".light_blue + document.content[0...100] + "\n\n"
nearest_documents = document.nearest_neighbors(
  :embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > 0.3 }

puts 'Similar documents:'.light_blue
nearest_documents.each do |doc|
  puts "- #{doc.content[0...100]} (#{doc.neighbor_distance.to_s.green})"
end
