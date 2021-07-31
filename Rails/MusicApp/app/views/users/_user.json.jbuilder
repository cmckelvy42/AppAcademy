json.extract! user, :id, :name, :email, :password_digest, :session_token, :created_at, :updated_at
json.url user_url(user, format: :json)
