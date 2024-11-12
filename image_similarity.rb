require 'neighbor'
require_relative 'shared/jina_ai_embedder'
require_relative 'migrations/images'
require_relative 'models/image'
require_relative 'shared/image_seeds'
require_relative 'shared/colorize'

MIN_DISTANCE = 0.6
query_image = Image.find_by(name: 'dachshund')
nearest_images = query_image.nearest_neighbors(
  :embedding,
  distance: 'inner_product'
).limit(5).select { |v| v.neighbor_distance > MIN_DISTANCE }
puts "#{'Query image:'.light_blue}\n#{query_image.name}\n\n"

puts "#{'Finding similar images:'.light_blue}\n"
nearest_images.each do |image|
  puts "- #{image.name} (#{image.neighbor_distance.to_s.green})"
end
