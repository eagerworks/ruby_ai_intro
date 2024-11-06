require 'active_record'
require_relative './embedder'

class Document < ActiveRecord::Base
  has_neighbors :embedding

  after_create :generate_embedding

  private

  def generate_embedding
    embedding = ::Embedder.embed(self.content)
    update(embedding: embedding)
  end
end
