require 'logger'

LOG_LEVEL = ENV['LOG_LEVEL']
LOG = Logger.new(LOG_LEVEL.nil? ? 'out.log' : $stdout)
LOG.level = if LOG_LEVEL.to_i.between?(Logger::Severity::DEBUG, Logger::Severity::FATAL)
              LOG_LEVEL.to_i
            else
              Logger::Severity::DEBUG
            end