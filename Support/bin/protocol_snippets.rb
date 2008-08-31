$KCODE = 'u'

class ProtocolSnippetNotSupported < Exception; end

require "yaml"
require "ui"

class ProtocolSnippet
  attr_reader :protocol_class
  
  def initialize(protocol_class)
    @protocol_class = protocol_class.strip
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
    protocol_definition[:required].inject([]) do |mem, required_method|
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
      self.class.protocol_definitions[protocol_class]
    end
  end
  
  def self.protocol_definitions
    @protocol_definitions ||= begin
      YAML.load(open(File.dirname(__FILE__) + "/../protocols.yml", "r"))
    end
  end
end

if __FILE__ == $0
  require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
  # TODO - useful alert + exit_discard if no hpricot
  require "rubygems"
  gem 'hpricot'
  require "hpricot"
  protocols = ProtocolSnippet.protocol_definitions
  TextMate.exit_discard unless protocol_class = TextMate::UI.menu(protocols.map { |item| {"title" => item} })
  protocol_class = protocol_class["title"]
  puts ProtocolSnippet.new(protocol_class).to_s
end
