# Rails + AI example

## Setup
Install [pgvector](https://github.com/pgvector/pgvector) for PostgreSQL vector similarity search.

Create the database
```sh
createdb rails_ai_test
```
If you are using another database, set the `DATABASE_NAME` environment variable.

Enable pgvector extension and generate migration for vector indices:
```sh
rails generate neighbor:vector
rails db:migrate
```

Export OpenAI API key as `OPENAI_API_KEY`.
```sh
export OPENAI_API_KEY=<your-openai-api-key>
```
Export Jina AI API key for image embeddings as `JINA_AI_API_KEY`.
```sh
export JINA_AI_API_KEY=<your-jina-ai-api-key>
```

Install dependencies
```sh
bundle install
```

## Run the scripts

### Text
```sh
# Semantic search
ruby semantic_search.rb
ruby document_similarity.rb
ruby rag.rb
```

### Images
```sh
ruby image_similarity.rb
```
