require 'logger'

$platform = (ENV['PLATFORM'] || 'android').downcase.to_sym
LOG_LEVEL = ENV['LOG_LEVEL']
PRETTY_PLATFORM = case $platform
                    when :ios
                      'iOS'
                    when :android
                      'Android'
                    else
                      raise "Unexpected platform provided: #{$platform}"
                  end

LOG = Logger.new(LOG_LEVEL.nil? ? 'out.log' : $stdout)
LOG.level = if LOG_LEVEL.to_i.between?(Logger::Severity::DEBUG, Logger::Severity::FATAL)
              LOG_LEVEL.to_i
            else
              Logger::Severity::DEBUG
            end

class String
  def camelize
    self.split('_').map(&:capitalize).join
  end
end

def redefine_for_platform!(parent_class_name)
  raise "Parent class not defined: #{parent_class_name}" unless Object.const_defined?(parent_class_name)
  platform_class_name = "#{parent_class_name}#{PRETTY_PLATFORM}"
  if Object.const_defined?(platform_class_name)
    LOG.debug("Redefining class #{parent_class_name} to be #{platform_class_name}")
    platform_class = Object.const_get(platform_class_name)
    Object.send(:remove_const, parent_class_name)
    Object.const_set(parent_class_name, platform_class)
  else
    LOG.debug("Platform class #{platform_class_name} not found. Leaving #{parent_class_name} as is")
  end
  defined_class = Object.const_get(parent_class_name)
  SUPPORT_TYPES.each do |support_type|
    support_module_name = "#{support_type.capitalize}Helper"
    LOG.debug("Extending #{parent_class_name} with #{support_module_name}")
    support_module = Object.const_get(support_module_name)
    defined_class.extend(support_module)
  end
  defined_class.extend(
      if $platform == :ios
        require 'calabash-cucumber/core'
        Calabash::Cucumber::Core
      else
        require 'calabash-android/operations'
        Calabash::Android::Operations
      end
  )
end

ENV_DIR = File.dirname(__FILE__)
SUPPORT_TYPES = %w(controller screen)

SUPPORT_TYPES.each do |folder_name|
  helper_file_path = File.join(ENV_DIR, folder_name, "#{folder_name}_helper.rb")
  LOG.debug("Requiring: #{helper_file_path}")
  require(helper_file_path)
end

SUPPORT_TYPES.each do |folder_name|
  file_mask = File.join(ENV_DIR, folder_name, "*_#{folder_name}.rb")
  Dir.glob(file_mask).each do |matched_file|
    LOG.debug("Requiring #{matched_file}")
    # noinspection RubyResolve
    require(matched_file)
    parent_class_name = File.basename(matched_file, '.rb').camelize
    LOG.debug("Assuming parent class from #{matched_file} is called #{parent_class_name}")
    redefine_for_platform!(parent_class_name)
  end
  LOG.info("Redefined all classes for #{folder_name} folder")
end
