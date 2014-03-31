module LostCanvas

  # LostCanvas Image representation.
  class Image

    # Open and decode the given file. 
    #
    # @param [String] file_path path to the target image file.
    # @return [LostCanvas::Image] abstract image representation.
    def self.open file_path
      File.open(file_path)

      self.new
    end

    # Returns the image heigth in pixels.
    #
    # @return [Fixnum] image height in pixels.
    def heigth
      1
    end

    # Encode and save the image.
    #
    # @return [TrueClass] whether the image was successfully saved or not. 
    def save
      true
    end

    # Returns the image width in pixels.
    #
    # @return [Fixnum] image width in pixels.
    def width
      1
    end

  end

end
