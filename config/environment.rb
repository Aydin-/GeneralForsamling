# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
GeneralForsamling::Application.initialize!


begin
APP_TEXT = YAML::load(File.open("#{RAILS_ROOT}/config/messages.yml"))
rescue
APP_TEXT = Hash.new('')
STDERR.puts "Message file not found"
end