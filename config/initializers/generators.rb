# Configure rails to use UUID-based primary keys instead of sequential integers:
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end
