json.extract! note, :id, :note, :track_id, :user_id, :created_at, :updated_at
json.url note_url(note, format: :json)
