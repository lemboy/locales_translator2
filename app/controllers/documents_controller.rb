class DocumentsController < ApplicationController

  def index
    PrepareTranslator.call
  end
 
  def new
    @document = Document.new()
    uploading = UploadSource.call(document: @document, src_file: params[:src_file])
    if uploading.success?
      Translator.from_code = @document.src_lang_code      
      status = AJAX_STATUS_OK 
    else
      flash[:danger] = uploading.error
      status = AJAX_STATUS_ERROR
    end     
    respond_to do |format|
      format.html { render 'new', :formats => [:js], status: status }
    end
  end

  def create
    creation = CreateFile.call(params: params)
    if creation.success?
      send_data creation.content, :filename => creation.file_name
    else
      flash[:danger] = creation.error
      respond_to do |format|
        format.html { render :formats => [:js]}
      end
    end      
  end
end