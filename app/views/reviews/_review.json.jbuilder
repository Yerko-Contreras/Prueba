json.extract! review, :id, :score, :content, :created_at, :updated_at
json.url review_url(review, format: :json)
