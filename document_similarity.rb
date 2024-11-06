require 'neighbor'
require 'openai'
OpenAI.configure { |config| config.access_token = ENV.fetch('OPENAI_API_KEY') }
require_relative 'migrations/documents'
require_relative 'models/document'
require_relative 'shared/document_seeds'
require_relative 'shared/colorize'

# Document similarity
MIN_DISTANCE = 0.3
document = Document.first
puts "Input document: \n".light_blue + document.content[0...100] + "\n\n"
nearest_documents = document.nearest_neighbors(
  :embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > MIN_DISTANCE }

puts 'Similar documents:'.light_blue
nearest_documents.each do |doc|
  puts "- #{doc.content[0...100]} (#{doc.neighbor_distance.to_s.green})"
end
