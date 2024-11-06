require 'neighbor'
require 'openai'
OpenAI.configure { |config| config.access_token = ENV.fetch('OPENAI_API_KEY') }
require_relative 'migrations/documents'
require_relative 'models/document'
require_relative 'shared/document_seeds'
require_relative 'shared/colorize'

# Semantic search
query = 'Something that barks, has fur and four legs.'
query_embedding = OpenAiEmbedder.embed(query)
puts "Query: \n".light_blue + query + "\n\n"

puts 'Search results:'.light_blue
MIN_DISTANCE = 0.3
nearest_documents = Document.nearest_neighbors(
  :embedding,
  query_embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > MIN_DISTANCE }

nearest_documents.each do |doc|
  puts "- #{doc.content[0...100]} (#{doc.neighbor_distance.to_s.green})"
end
