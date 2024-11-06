require 'active_record'
require_relative '../shared/open_ai_embedder'

class Document < ActiveRecord::Base
  has_neighbors :embedding

  after_create :generate_embedding

  private

  def generate_embedding
    embedding = ::OpenAiEmbedder.embed(self.content)
    update(embedding: embedding)
  end
end
