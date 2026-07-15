# app/uploaders/application_uploader.rb
class ApplicationUploader < CarrierWave::Uploader::Base
  # Every uploader in our app will now automatically use MiniMagick
  include CarrierWave::MiniMagick

  # Standardize on file storage for all uploaders
  storage :file

  # Global file type validation to protect your server
  def extension_whitelist
    %w(jpg jpeg gif png webp)
  end
end