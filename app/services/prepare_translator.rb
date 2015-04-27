class PrepareTranslator

  include Service
  include TranslatorService

  def initialize(attr = {})
    reset_error
    Translator.dirs = @dirs if machine('get_dirs')
    Translator.enabled = @success
  end

end