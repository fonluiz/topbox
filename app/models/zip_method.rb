class ZipMethod < CompressionMethod

  EXTENSION = 'zip'

  def self.compress(text)
    Zlib.deflate(text)
  end

  def self.decompress(compressed_text)
    Zlib.inflate(compressed_text)
  end

  def self.get_extension
    EXTENSION
  end

end