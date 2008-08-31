class ProtocolSnippetNotSupported < Exception; end

class ProtocolSnippet
  attr_reader :protocol_class
  
  def initialize(protocol_class)
    @protocol_class = protocol_class
    raise ProtocolSnippetNotSupported, protocol_class unless supported?
  end
  
  def supported?
    available = %w[UITableViewDelegate UITableViewDataSource]
    available.include?(protocol_class)
  end
  
  def to_s
    header
  end
  
  def header
    <<-OBJC
#pragma mark -
#pragma mark - #{@protocol_class} methods
    OBJC
  end
end

if __FILE__ == $0
  require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"

  puts "TODO - implement ProtocolSnippet"
  TextMate.exit_discard
end