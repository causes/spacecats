$LOAD_PATH.unshift(File.expand_path(File.join(File.dirname(__FILE__), 'lib')))

require 'bundler/setup'
require 'spacecat/app'

run Spacecat::App
