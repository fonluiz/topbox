module FoldersHelper

  PAGE_MAX = 9
  NEW_FOLDER_NAME = "Nova Pasta"


  def folder_created_msg(folder_name)
    "A pasta #{folder_name} foi criada com sucesso."
  end

  def folder_destroyed_msg(folder_name)
    "A pasta #{folder_name} foi apagada."
  end

  def folder_updated_msg(folder_name)
    "A pasta #{folder_name} foi atualizada."
  end
end
