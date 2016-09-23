class GzipMethod < CompressionMethod
  EXTENSION = 'gz'

  def self.compress(text)
    ActiveSupport::Gzip.compress(text)
  end

  def self.decompress(compressed_text)
    ActiveSupport::Gzip.decompress(compressed_text)
  end

  def self.get_extension
    EXTENSION
  end

end