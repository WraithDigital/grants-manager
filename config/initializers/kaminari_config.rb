# frozen_string_literal: true
Kaminari.configure do |config|
  # config.default_per_page = 25
  config.max_per_page = 200
  config.window = 4
  config.outer_window = 2
  # config.left = 2
  # config.right = 2
  # config.page_method_name = :page
  # config.param_name = :page
  # config.params_on_first_page = false
end
