require 'active_record'

DATABASE_NAME = 'rails_ai_test'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: DATABASE_NAME
)
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  enable_extension 'vector'

  create_table :documents, if_not_exists: true do |t|
    t.text :content
    t.vector :embedding, limit: 1536
  end

  # needed for full text search
  add_index :documents, "to_tsvector('english', coalesce(content, ''))",
    using: :gin, if_not_exists: true
  # needed for nearest neighbors
  add_index :documents, :embedding, using: :hnsw, opclass: :vector_ip_ops,
    if_not_exists: true
end
