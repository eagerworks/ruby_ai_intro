module OpenAiEmbedder
  EMBEDDING_MODEL = 'text-embedding-3-small'

  def self.embed(content)
    response = client.embeddings(
      parameters: {
        model: EMBEDDING_MODEL,
        input: content
      }
    )
    response.dig('data', 0, 'embedding')
  end

  def self.client
    @client ||= OpenAI::Client.new
  end
end
