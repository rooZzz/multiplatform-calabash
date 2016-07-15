class Hash
  def merge_default!
    {timeout: 30, should_wait: true, throw: true, use_keyboard: true}.each do |key, value|
      self[key] = value unless self.include?(key)
    end
  end
end

module ControllerHelper

  def ios?
    # noinspection RubyResolve
    $platform == :ios
  end

  def touch_when_element_exists(query, opts={})
    LOG.debug("Touching when element exists: #{query}")
    does_element_exist(query, opts)
    touch(query)
  end

  def does_element_not_exist(query)
    sleep 1
    LOG.debug("Checking element does not exist: #{query}")
    element_does_not_exist(query)
  end

  def does_element_exist(query, opts={})
    opts.merge_default!
    if opts[:should_wait]
      wait_for_none_animating(timeout: 2) if ios?
      LOG.debug("Waiting for element to exist: #{query}")
      wait_for_element_exists(query, opts)
    end
    LOG.debug("Querying element: #{query}")
    results = query(query)
    raise "Couldn't find any results for query: #{query} and wait options: #{opts}" if results.empty? && opts[:throw]
    results
  end

  def get_element(query, opts={})
    does_element_exist(query, opts).first
  end

  def input_text(text, opts={})
    LOG.debug("Inputting text: #{text}")
    input_text_into_field(nil, text, opts)
  end

  def input_text_into_field(query, text, opts={})
    opts.merge_default!
    if query.nil?
      LOG.debug("Attempting to enter text: '#{text}'")
      ios? ? keyboard_enter_text(text) : keyboard_enter_text(text, opts)
    else
      LOG.debug("Attempting to enter text: '#{text}' into #{query}")
      enter_text(query, text, opts)
      hide_soft_keyboard unless ios?
    end
  end

end