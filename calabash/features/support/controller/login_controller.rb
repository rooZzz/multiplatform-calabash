class LoginController

  def self.check_on_screen
    does_element_exist(LoginScreen.screen)
  end

  def self.enter_passcode(passcode_type)
    case passcode_type
      when 'correct'
        passcode = '1234'
      when 'wrong'
        passcode = '9999'
      else
        raise "Unexpected passcode_type: #{passcode_type}"
    end
    input_text_into_field(LoginScreen.passcode_entry, passcode)
  end

  def self.check_for_wrong_passcode
    does_element_exist(LoginScreen.passcode_wrong_title)
    does_element_exist(LoginScreen.passcode_wrong_text)
    touch_when_element_exists(LoginScreen.ok_text)
    does_element_not_exist(HomeScreen.screen)
  end

end

class LoginControllerAndroid < LoginController

  def self.enter_passcode(passcode_type)
    super
    touch_when_element_exists(LoginScreen.login_button)
  end

end