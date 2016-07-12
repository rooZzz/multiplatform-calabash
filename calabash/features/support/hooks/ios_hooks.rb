require 'calabash-cucumber/launcher'

class CalabashExitter
  include Calabash::Cucumber::Core

  def self.exit
    CalabashExitter.new.exit
  end

  def exit
    calabash_exit
  end

end

Before do |_|
  LOG.info('Attempting to relaunch iOS app')
  @launcher = Calabash::Cucumber::Launcher.new
  @launcher.relaunch
end

After do |_|
  LOG.info('Attempting to exit Calabash')
  CalabashExitter.exit
end