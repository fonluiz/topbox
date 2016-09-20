class ZipMethod < CompressionMethod

  EXTENSION = 'zip'

  def compress(text)
    Zlib.deflate(text)
  end

  def decompress(compressed_text)
    Zlib.inflate(compressed_text)
  end

  def get_extension
    EXTENSION
  end

end