require 'simplecov'

SimpleCov.start do
  add_group 'Models',      'app/models'
  add_group 'Controllers', 'app/controllers'
  add_group 'Validators',  'app/validators'
  add_group 'Mailers',     'app/mailers'
  add_group 'Constants',   'config/initializers/constants.rb'
end
