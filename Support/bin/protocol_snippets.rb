class ProtocolSnippet
  def self.for(protocol_class)
    
  end
  
  def self.supported_delegate_protocol_class?(protocol_class)
    available = %w[UITableViewDelegate UITableViewDataSource]
    available.include?(protocol_class)
  end
end

if __FILE__ == $0
  require ENV['TM_SUPPORT_PATH'] + "/lib/exit_codes"

  puts "TODO - implement ProtocolSnippet"
  TextMate.exit_discard
end