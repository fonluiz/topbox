# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!


# INTERNACIONALIZAÇÃO (IDIOMA) DA APP

# The internationalization framework can be changed
# to have another default locale (standard is :en) or more load paths.
# All files from config/locales/*.rb,yml are added automatically.
# config.i18n.load_path << Dir[File.join(RAILS_ROOT, 'my', 'locales', '*.{rb,yml}')]
# config.i18n.default_locale = :de

# definindo o local padrão para outra coisa que não :en
I18n.default_locale = :pt