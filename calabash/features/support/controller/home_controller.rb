class HomeController

  def self.check_on_screen
    does_element_exist(HomeScreen.screen)
  end

end