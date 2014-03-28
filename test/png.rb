require 'zlib'
require_relative '../lib/lost_canvas'

def pixel color
  case color
  when 'G' then [0,255,0].pack('C3')
  when 'R' then [255,0,0].pack('C3')
  when 'B' then [0,0,255].pack('C3')
  end
end

png = []

png << [137,80,78,71,13,10,26,10].pack('C8')

height = File.foreach("image.input").count
width  = File.open("image.input").readline.chomp!.size

data = [width,height,8,2,0,0,0,].pack("N2C5")
ihdr_chunk = LostCanvas::PNG::Chunk.new("IHDR",data)

png << ihdr_chunk.to_bytes

File.open('image.input') do |image|
  data = ''

  image.each_line do |line|
    break if line.chomp!.empty?
    data << [0].pack('C') << line.chars.collect {|c| pixel c}.join
  end

  png << LostCanvas::PNG::Chunk.new("IDAT",Zlib::Deflate.deflate(data)).to_bytes
end

png << LostCanvas::PNG::Chunk.new("IEND").to_bytes

File.open('prueba.png', 'w+') do |file|
  file.write png.join
end


