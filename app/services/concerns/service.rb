module Service
  extend ActiveSupport::Concern


  included do
    def self.call(attributes = {})
      self.new(attributes)
    end
  end
  
    attr_reader :success, :error
  
    def success?
      @success
    end
  
    private
    
      def reset_error
        @success = true
        @error = nil
      end
      
      def result(status, message)
        @success = status
        @error = message unless status 
        @success
      end

end

