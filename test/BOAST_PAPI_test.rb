[ '../lib', 'lib' ].each { |d| $:.unshift(d) if File::directory?(d) }
require 'minitest/autorun'
require 'BOAST'
include BOAST
require_relative 'Runtime/PAPI'
require_relative 'helper'
