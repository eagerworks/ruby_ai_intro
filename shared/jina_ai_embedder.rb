require 'httparty'

module JinaAiEmbedder
  EMBEDDING_MODEL = 'jina-clip-v1'
  URI = 'https://api.jina.ai/v1/embeddings'
  HEADERS = {
    'Content-Type' => 'application/json',
    'Authorization' => "Bearer #{ENV['JINA_AI_API_KEY']}"
  }

  def self.embed(content)
    data = {
      model: EMBEDDING_MODEL,
      normalized: true,
      embedding_type: 'float',
      input: [{ image: content }]
    }

    response = HTTParty.post(URI, headers: HEADERS, body: data.to_json)
    response.parsed_response.dig('data', 0, 'embedding')
  end
end
