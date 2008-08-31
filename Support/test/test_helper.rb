require "test/unit"

$:.unshift(File.dirname(__FILE__) + "/../bin")
$:.unshift(File.dirname(__FILE__) + "/../lib")
$:.unshift(File.dirname(__FILE__) + "/fixtures")

require "pp"

require "rubygems"
gem "Shoulda"
require "Shoulda"
gem "mocha"
require "mocha"

Context = Thoughtbot::Shoulda::Context unless Object.const_defined?("Context")