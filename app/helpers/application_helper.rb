module ApplicationHelper
  
  def app_current_locale
    t("app.locale_list.#{ I18n.locale }")
  end
  
  def app_locales_list
    l_list = ''
    I18n.available_locales.each do |i|
     l_list << content_tag(:li, link_to(t("app.locale_list.#{ i }"), root_path(locale: i))) if i != I18n.locale
    end
    l_list.html_safe   
  end
end
