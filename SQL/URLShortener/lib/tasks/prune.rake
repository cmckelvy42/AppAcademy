namespace :prune do
    desc "Purge links that haven't been used in X days"
    task purge_old_urls: :environment do
        days = ENV['hours'].to_i || 72
        puts "Pruning old URLs..."
        ShortenedUrl.prune(days)
    end

end