require 'neighbor'
require 'openai'
OpenAI.configure { |config| config.access_token = ENV.fetch('OPENAI_API_KEY') }
require_relative 'migrations/documents'
require_relative 'models/document'
require_relative 'shared/document_seeds'
require_relative 'shared/colorize'


# RAG: Retrieval Augmented Generation
query = 'For each company, give me the profits for the 2024 fiscal year.'
query_embedding = OpenAiEmbedder.embed(query)
puts "Query: \n".light_blue + query + "\n\n"

MIN_DISTANCE = 0.5
nearest_documents = Document.nearest_neighbors(
  :embedding,
  query_embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > MIN_DISTANCE }
query_context = nearest_documents.map(&:content).join("\n")
puts "Context for query: \n".light_blue + query_context + "\n\n"

response = OpenAI::Client.new.chat(
  parameters: {
    model: 'gpt-4o-mini',
    messages: [
      { role: 'system', content: 'You are a helpful assistant. You are given a query and some relevant context. You need to answer the user query based on the provided context. ONLY USE THAT INFORMATION TO ANSWER THE QUERY. DO NOT MAKE UP ANY INFORMATION. FORGET WHAT YOU KNOW ABOUT THE WORLD OUTSIDE THE QUERY AND THE CONTEXT.' },
      { role: 'user', content: "Query: #{query}\n Context: #{query_context}" }
    ],
    temperature: 0.1,
  }
)
puts 'RAG results:'.light_blue
puts response.dig('choices', 0, 'message', 'content')
