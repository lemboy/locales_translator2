require 'yaml'
require 'erb'

LOCALES_LIST = YAML.load(ERB.new(File.new(Rails.root.join("config", "locales_list.yml")).read).result)['locales'] || {}
YANDEX_API_KEY = ENV["YANDEX_API_KEY"]
AJAX_STATUS_OK = 200
AJAX_STATUS_ERROR = 404
