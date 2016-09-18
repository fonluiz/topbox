module DocumentsHelper

    NEW_DOCUMENT_NAME = "Documento sem título"

    GZIP_EXTENSION = 'gz'

    def get_extension_out_of_name(title)
        extension = ''
        title.reverse.each_char do |char|
           unless char == '.'
               extension = char + extension
           else
            return extension
           end
        end
    end

end
