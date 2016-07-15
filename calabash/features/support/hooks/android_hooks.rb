require 'calabash-android/operations'

$first_run = true

Before do |_|
  if $first_run
    $first_run = false
    uninstall_apps
    install_app(ENV['TEST_APP_PATH'])
    install_app(ENV['APP_PATH'])
  end
  clear_app_data
  start_test_server_in_background
end
