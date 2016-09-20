class GzipMethod < CompressionMethod

  EXTENSION = 'gz'

  def compress(text)
    ActiveSupport::Gzip.compress(text)
  end

  def decompress(compressed_text)
    ActiveSupport::Gzip.decompress(compressed_text)
  end

  def get_extension
    EXTENSION
  end

end