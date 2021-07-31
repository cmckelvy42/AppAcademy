json.extract! track, :id, :title, :album_id, :ord, :bonus, :lyrics, :created_at, :updated_at
json.url track_url(track, format: :json)
