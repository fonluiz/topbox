class CompressionMethod
  include DocumentsHelper

  def compress
    raise NotImplementedError, 'The method "compress" is not implemented!'
  end

  def decompress
    raise NotImplementedError, 'The method "decompress" is not implemented!'
  end

end