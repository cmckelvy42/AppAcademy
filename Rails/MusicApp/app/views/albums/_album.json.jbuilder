json.extract! album, :id, :title, :year, :band_id, :live, :created_at, :updated_at
json.url album_url(album, format: :json)
