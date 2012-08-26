$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))

Bundler.setup

RSpec.configure do |config|
  config.filter_run(focus: true)
  config.run_all_when_everything_filtered = true
end