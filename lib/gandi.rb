# Add the directory containing this file to the start of the load path if it
# isn't there already.
$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'xmlrpc/client'
require 'gandi/session'
require 'gandi/errors'

# Gandi/Ruby Library
#
# Author::    Jérôme Lipowicz (mailto:jerome@yayel.com)
# License::   MIT License

class Array
  # from ActiveSupport::CoreExtensions::Array::ExtractOptions
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end

module Gandi
  VERSION = '1.0.0'
end
