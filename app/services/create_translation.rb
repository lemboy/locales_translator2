class CreateTranslation

  include Service
  include TranslatorService

  def initialize(attr = {})
    params = attr
    reset_error
    machine(
      'translate', 
      { 
        source: params[:src_plain_array], 
        from: params[:document][:src_lang_code], 
        to: params[:document][:trgt_lang_code] 
      })
  end

end