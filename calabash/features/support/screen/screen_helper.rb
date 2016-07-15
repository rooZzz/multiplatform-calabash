module ScreenHelper

  def escape(text)
    text.to_s.gsub("'", "\\\\'")
  end

  def by_text(text)
    "* text:'#{escape(text)}'"
  end

  def by_id(id)
    "* id:'#{id}'"
  end

end