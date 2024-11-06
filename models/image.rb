require 'active_record'
require_relative '../shared/jina_ai_embedder'

class Image < ActiveRecord::Base
  has_neighbors :embedding

  after_create :generate_embedding

  private

  def generate_embedding
    embedding = ::JinaAiEmbedder.embed(self.base64_image)
    update(embedding: embedding)
  end
end
