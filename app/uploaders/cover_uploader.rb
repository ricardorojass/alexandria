class CoverUploader < CarrierWave::Uploader::Base
  storage :file

  def defatul_url
    url = "uploads/#{model.class.to_s.underscore}/#{mounted_as}/default/cover.jpg"
    url.prepend('/') unless url[0] == '/'
    url
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_whitelist
    %w(jpg jpeg gif png)
  end

end
