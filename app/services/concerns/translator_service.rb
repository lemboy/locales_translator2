module TranslatorService
  extend ActiveSupport::Concern

  attr_reader :dirs, :result

  private  

    def machine(action, params = {})
      source_content = params[:source].inject("") { |h, (k, v)| "#{ h }[#{ v }]" } if action.include?('translate')

      begin
        transl = Yandex::Translator.new(YANDEX_API_KEY)
        response = transl.langs if action.include?('get_dirs')
        response = transl.translate(source_content, 
                                    from: params[:from], 
                                    to: params[:to]) if action.include?('translate')
      rescue SocketError => e
        return process_error('mt.error.library_error', e.message)
      rescue Yandex::ApiError => e
        return process_error('mt.error.machine_error', e.message)
      else
        return @dirs = response if action.include?('get_dirs')

        target_array, target_hash = response.gsub(/^\[|\]$/, '').split("]["), params[:source]
        target_hash.each_with_index do |(k,v), i| 
          target_hash[k] = target_array[i]
        end
        @result = target_hash      
      end      
    end
    
    def process_error(context, message)
      Rails.logger.debug "#{ I18n.t(context) } #{ message }"
      @error = "#{ I18n.t(context) } #{ message }"
      @success = false
    end  

end

