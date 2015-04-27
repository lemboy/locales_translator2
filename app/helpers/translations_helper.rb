module TranslationsHelper
  def get_uls(prev_level, level)
    ("</ul>" * (prev_level - level)).html_safe if level < prev_level
  end

  def get_attributes(is_group, id)
    key_class = is_group ? "bg-info glyphicon glyphicon-minus-sign" : "bg-warning"
    transl_class = "inner glyphicon glyphicon-play-circle " + ( id.zero? ? "auto-transl-all" : "auto-transl")
    transl_id = is_group ? (id.zero? ? "auto-transl-all" : "") : "auto-transl-#{id}"
    transl_title =  id.zero? ? t('form.title.translate_all') : t('form.title.translate_this')
    [key_class, transl_class, transl_id, transl_title]      
  end
  
  def get_ulorli(is_group)
    is_group ? "<ul>".html_safe : "</li>".html_safe
  end
  
  def get_ullis(level, id, size)
    ("</ul></li>" * (level - 1)).html_safe if id == (size - 1)
  end
end