require_relative 'png/chunk.rb'

module LostCanvas

  class PNG

    SIGNATURE = [137, 80, 78, 71, 13, 10, 26, 10]

    def self.open(file_path)
      file = File.open(file_path,'rb')
      raise "Invalid signature" unless valid_signature?(file)
  
      chunks = []
      until file.eof?
        chunk = Chunk.new
        chunk.size = file.read(4).unpack("N").first         #Negrada de Ruby
        chunk.type = file.read(4)
        chunk.data = file.read(chunk.size)
        chunk.crc = file.read(4)
    
        chunks << chunk
      end
      chunks
      #Ahora que tenemos los Chunks faltaria armar un objeto mas manipulable
    end

    private 

    def valid_signature?(file)
      file.read(8).bytes == SIGNATURE
    end


  end

end
