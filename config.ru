$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'page_configurator'

run PageConfigurator::Api.new