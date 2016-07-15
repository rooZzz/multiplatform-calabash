class LoginScreen

  def self.screen
    by_text('Login')
  end

  def self.welcome_text
    raise NotImplementedError
  end

  def self.passcode_entry
    by_id('passcode_entry')
  end

  def self.login_text(platform)
    by_text("Welcome to the #{platform} app. Please login.")
  end

  def self.passcode_wrong_title
    by_text('Incorrect passcode')
  end

  def self.passcode_wrong_text
    by_text('Sorry, your passcode was incorrect. Please try again.')
  end

  def self.ok_text
    raise NotImplementedError
  end

end

class LoginScreeniOS < LoginScreen

  def self.welcome_text
    login_text('iOS')
  end

  def self.ok_text
    by_text('Ok')
  end

end

class LoginScreenAndroid < LoginScreen

  def self.welcome_text
    login_text('Android')
  end

  def self.login_button
    by_id('login_button')
  end

  def self.ok_text
    by_text('OK')
  end


end