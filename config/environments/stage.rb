# Use the production environment settings - this keeps the app as close to production as possible:
require File.expand_path('../production.rb', __FILE__)

Rails.application.configure do
  # Here override anything from production.
  config.active_storage.service = :s3_development
end
