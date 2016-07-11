module ScreenHelper

  def self.escape(text)
    text.to_s.gsub("'", "\\\\'")
  end

  def self.by_text(text)
    "* text: #{escape(text)}"
  end

  def self.by_id(id)
    "* id: #{id}"
  end

end