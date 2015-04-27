class Translator
  include ActiveModel::Model

  class << self

    attr_accessor :enabled, :dirs, :from_code

    def enabled?
      @enabled
    end

    def lang_list
      @dirs ||= []
      @from_code ||= ''
      LOCALES_LIST.map {|k, v| [ "#{ v['name'] } (#{ k })" + (@dirs.select { |e| e =~ /#{ @from_code }-#{ k }/ }.present? ? " *" : ""), k ]}
    end
  
    def lang_name(code)
      @dirs ||= []
      "#{ LOCALES_LIST[code]['name'] } (#{ code })" + (@dirs.select { |e| e =~ /#{ code }-/ }.present? ? " *" : "")
    end
  end  
end