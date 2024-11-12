require 'base64'

assets_path = File.expand_path('../../assets/*.jpg', __FILE__)
Dir.glob(assets_path).each do |image_path|
  base64_image = Base64.encode64(File.open(image_path, 'rb').read)
  name = File.basename(image_path, '.jpg')
  Image.find_or_create_by(base64_image: base64_image, name: name)
end
