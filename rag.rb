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


# RAG: Retrieval Augmented Generation
query = 'For each company, give me the profits for the 2024 fiscal year.'
query_embedding = Embedder.embed(query)
puts "Query: \n".light_blue + query + "\n\n"

nearest_documents = Document.nearest_neighbors(
  :embedding,
  query_embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > 0.5 }
query_context = nearest_documents.map(&:content).join("\n")
puts "Context for query: \n".light_blue + query_context + "\n\n"

response = OpenAI::Client.new.chat(
  parameters: {
    model: 'gpt-4o-mini',
    messages: [
      { role: 'system', content: 'You are a helpful assistant. You are given a query and some relevant context. You need to answer the user query based on the provided context. ONLY USE THAT INFORMATION TO ANSWER THE QUERY. DO NOT MAKE UP ANY INFOMRATION. FORGET WHAT YOU KNOW ABOUT THE WORLD OUTSIDE THE QUERY AND THE CONTEXT.' },
      { role: 'user', content: "Query: #{query}\n Context: #{query_context}" }
    ],
    temperature: 0.1,
  }
)
puts 'RAG results:'.light_blue
puts response.dig('choices', 0, 'message', 'content')
