# Rails + AI example

## Setup
Install [pgvector](https://github.com/pgvector/pgvector) for PostgreSQL vector similarity search.

Create the database
```sh
createdb rails_ai_test
```

Enable pgvector extension and generate migration for vector indices.
```sh
rails generate neighbor:vector
rails db:migrate
```

Export OpenAI API key as `OPENAI_API_KEY`.
```sh
export OPENAI_API_KEY=<your-openai-api-key>
```

Install dependencies
```sh
bundle install
```

Run the scripts
```sh
bundle exec ruby semantic_search.rb
bundle exec ruby document_similarity.rb
bundle exec ruby rag.rb
```
