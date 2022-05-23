json.extract! chat, :id, :content, :created_at, :updated_at
json.url chat_url(chat, format: :json)
