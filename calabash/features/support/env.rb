require_relative 'init/monkey_patches'
require_relative 'init/init_logger'

$platform = (ENV['PLATFORM'] || 'android').downcase.to_sym
if $platform == :ios
  require 'calabash-cucumber/operations'
  require_relative 'hooks/ios_hooks'
  World(Calabash::Cucumber::Core)
else
  require 'calabash-android/operations'
  require_relative 'hooks/android_hooks'
  World(Calabash::Android::Operations)
end
require_relative 'hooks/common_hooks'

PRETTY_PLATFORM = case $platform
                    when :ios
                      'iOS'
                    when :android
                      'Android'
                    else
                      raise "Unexpected platform provided: #{$platform}"
                  end
ENV_DIR = File.dirname(__FILE__)
SUPPORT_TYPES = %w(controller screen)

def redefine_for_platform!(parent_class_name)
  raise "Parent class not defined: #{parent_class_name}" unless Object.const_defined?(parent_class_name)
  platform_class_name = "#{parent_class_name}#{PRETTY_PLATFORM}"
  if Object.const_defined?(platform_class_name)
    LOG.debug("Redefining class #{parent_class_name} to be #{platform_class_name}")
    platform_class = Object.const_get(platform_class_name)
    Object.send(:remove_const, parent_class_name)
    Object.send(:remove_const, platform_class_name)
    Object.const_set(parent_class_name, platform_class)
  else
    LOG.debug("Platform class #{platform_class_name} not found, leaving #{parent_class_name} as is")
  end
  defined_class = Object.const_get(parent_class_name)
  SUPPORT_TYPES.each do |support_type|
    support_module_name = "#{support_type.capitalize}Helper"
    LOG.debug("Extending #{parent_class_name} with #{support_module_name}")
    support_module = Object.const_get(support_module_name)
    defined_class.extend(support_module)
  end
  if $platform == :ios
    defined_class.extend(Calabash::Cucumber::Operations)
  else
    defined_class.extend(Calabash::Android::Operations)
  end
end

SUPPORT_TYPES.each do |folder_name|
  helper_file_path = File.join(ENV_DIR, folder_name, "#{folder_name}_helper.rb")
  LOG.debug("Requiring: #{helper_file_path}")
  # noinspection RubyResolve
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
