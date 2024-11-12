require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: ENV.fetch('DATABASE_NAME', 'rails_ai_test')
)
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  enable_extension 'vector'

  create_table :images, if_not_exists: true do |t|
    t.text :name
    t.text :base64_image
    t.vector :embedding, limit: 768
  end

  add_index :images, :embedding, using: :hnsw, opclass: :vector_ip_ops,
    if_not_exists: true
end
