class String
  def camelize
    self.split('_').map(&:capitalize).join
  end
end

def pretty_platform(platform)
  case platform
    when :ios
      'iOS'
    when :android
      'Android'
    else
      raise "Unexpected platform provided: #{platform}"
  end
end

def redefine_for_platform!(platform)

end

platform = (ENV['PLATFORM'] || 'android').downcase.to_sym
env_dir = File.dirname(__FILE__)

%w(controller screen).each do |folder_name|
  file_mask = File.join(env_dir, folder_name, "*_#{folder_name}.rb")
  Dir.glob(file_mask).each do |matched_file|
    puts File.basename(matched_file, '.rb').camelize
    require(matched_file)
    redefine_for_platform!(platform)
  end
end
