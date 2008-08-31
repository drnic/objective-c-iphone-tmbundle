class ProtocolSnippetNotSupported < Exception; end

require "yaml"

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
end

if __FILE__ == $0
  require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"

  puts "TODO - implement ProtocolSnippet"
  TextMate.exit_discard
end