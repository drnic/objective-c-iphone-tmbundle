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
      doc_root = "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone2_0.iPhoneLibrary.docset/Contents/Resources/Documents/documentation"
      protocol_docs = Dir[doc_root + "/*/Reference/*_Protocol/*/*.html"]
      protocol_docs.inject({}) do |docs, path|
        doc = Hpricot(open(path))
        name       = doc.search("h1").inner_html.gsub(/\s+Protocol Reference/, "")
        next docs if name == "Index" || name.index(" ")
        method_interfaces = doc.search("p.spaceabovemethod").map { |method| method.inner_html.gsub(/<[^>]*>/,'') }
        compact_methods = method_interfaces.inject({}) do |mem, method|
          compact = method.gsub(/\([^)]+\)/,'').scan(/\w+\:/).join # TODO - only methods with args, no properties or no-arg methods
          mem[compact] = method
          mem
        end
        required   = []
        optional   = []
        method_index = doc.search("li.tooltip span")
        method_index.each do |method|
          compact_name = method.search("code a").inner_html.gsub("&#8211;", "").gsub("&#xA0;", "")
          next if compact_name.length == 0
          full_spec   = compact_methods[compact_name]
          if method.search("span.task_api_suffix").size == 0
            required << full_spec
          else
            optional << full_spec
          end
        end
        docs[name] = { :name => name, :path => path, :required => required, :optional => optional }
        docs
      end
    end
  end
end

if __FILE__ == $0
  require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"
  # TODO - useful alert + exit_discard if no hpricot
  require "rubygems"
  gem 'hpricot'
  require "hpricot"
  gem "htmlentities"
  require "htmlentities"
  protocols = ProtocolSnippet.protocol_definitions
  TextMate.exit_discard unless protocol_class = TextMate::UI.menu(protocols.map { |item| {"title" => item} })
  protocol_class = protocol_class["title"]
  puts ProtocolSnippet.new(protocol_class).to_s
end
