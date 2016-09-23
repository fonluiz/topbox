class CompressionMethod
  include DocumentsHelper

  def self.compress
    raise NotImplementedError, 'The method "compress" is not implemented!'
  end

  def self.decompress
    raise NotImplementedError, 'The method "decompress" is not implemented!'
  end

  def self.get_extension
    raise NotImplementedError, 'The method "get_extension" is not implemented!'
  end

end