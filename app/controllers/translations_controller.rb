class TranslationsController < ApplicationController

  def create
    creation = CreateTranslation.call(params)
    if creation.success?
      @target = creation.result
      status = AJAX_STATUS_OK
    else
      flash[:danger] = creation.error 
      status = AJAX_STATUS_ERROR
    end
    respond_to do |format|
      format.html { render :formats => [:js], status: status }
    end
  end
  
end
