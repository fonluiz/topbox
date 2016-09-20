class GzipMethod < CompressionMethod

  GZIP_EXTENSION = 'gz'

  def compress(document)
    document.content = ActiveSupport::Gzip.compress(document.content)
    document.name += ('.' + document.extension)
    document.extension = GZIP_EXTENSION
    document
  end

  def decompress(document)
    document.content = ActiveSupport::Gzip.decompress(document.content)
    document.extension = get_extension_out_of_name(document.name)
    document.name = document.name[0..(-GZIP_EXTENSION.length - 2)]
    document
  end

end