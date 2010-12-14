# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MongoOnRailsBlog::Application.initialize!

config.serve_static_assets = true
