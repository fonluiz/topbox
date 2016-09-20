class ZipMethod < CompressionMethod

  ZIP_EXTENSION = 'zip'

  def compress(document)
    document.content = Zlib.deflate(document.content)
    document.name += ('.' + document.extension)
    document.extension = ZIP_EXTENSION
    document
  end

  def decompress(document)
    document.content = Zlib.inflate(document.content)
    document.extension = get_extension_out_of_name(document.name)
    document.name = document.name[0..(-ZIP_EXTENSION.length - 2)]
    document
  end

end