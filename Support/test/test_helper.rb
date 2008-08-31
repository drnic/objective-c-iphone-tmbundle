require "test/unit"

$:.unshift(File.dirname(__FILE__) + "../bin")
$:.unshift(File.dirname(__FILE__) + "../lib")

require "pp"

require "rubygems"
gem "Shoulda"
require "Shoulda"
gem "mocha"
require "mocha"

Context = Thoughtbot::Shoulda::Context