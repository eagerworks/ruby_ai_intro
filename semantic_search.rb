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

# Semantic search
query = 'Something that barks, has fur and four legs.'
query_embedding = Embedder.embed(query)
puts "Query: \n".light_blue + query + "\n\n"

puts 'Search results:'.light_blue
nearest_documents = Document.nearest_neighbors(
  :embedding,
  query_embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > 0.3 }

nearest_documents.each do |doc|
  puts "- #{doc.content[0...100]} (#{doc.neighbor_distance.to_s.green})"
end
