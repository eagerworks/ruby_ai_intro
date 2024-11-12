require 'httparty'

module OpenAiEmbedder
  EMBEDDING_MODEL = 'text-embedding-3-small'
  URI = 'https://api.openai.com/v1/embeddings'
  HEADERS = {
    'Content-Type' => 'application/json',
    'Authorization' => "Bearer #{ENV['OPENAI_API_KEY']}"
  }

  def self.embed(content)
    data = {
      model: EMBEDDING_MODEL,
      input: content
    }

    response = HTTParty.post(URI, headers: HEADERS, body: data.to_json)
    response.parsed_response.dig('data', 0, 'embedding')
  end
end
