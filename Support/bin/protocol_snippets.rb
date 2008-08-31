class ProtocolSnippetNotSupported < Exception; end

require "yaml"
require "ui"

class ProtocolSnippet
  attr_reader :protocol_class
  
  def initialize(protocol_class)
    @protocol_class = protocol_class
    raise ProtocolSnippetNotSupported, protocol_class unless supported?
  end
  
  def supported?
    protocol_definition
  end
  
  def to_s
    header +
    render_required_methods
  end
  
  def header
    <<-OBJC
#pragma mark -
#pragma mark - #{@protocol_class} methods

    OBJC
  end
  
  def render_required_methods
    protocol_definition["required"].inject([]) do |mem, required_method|
      mem << <<-OBJC
#{required_method}
{
  #{"$0" if mem.size == 0}
}
      OBJC
      mem
    end.join("\n")
  end
  
  def protocol_definition
    @protocol_definition ||= begin
      file = File.dirname(__FILE__) + "/../protocols/#{protocol_class}.yml"
      return nil unless File.exists?(file)
      YAML.load(File.read(file))
    end
  end
  
  def self.protocol_definitions
    Dir[File.dirname(__FILE__) + "/protocols/*.yml"].map { |file| File.basename(file).gsub(/\.yml$/,'') }
  end
end

if __FILE__ == $0
  require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
  protocols = ProtocolSnippet.protocol_definitions
  TextMate.exit_discard unless protocol_class = TextMate::UI.menu(:title => "Select protocol class", :items => protocols)
  
  puts ProtocolSnippet.new(protocol_class).to_s
end