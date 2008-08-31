require File.dirname(__FILE__) + "/test_helper"

require "protocol_snippets"

class TestProtocolSnippets < Test::Unit::TestCase
  should "generate UITableView delegate protocol" do
    expected = <<-OBJC
#pragma mark -
#pragma mark - UITableViewDelegate methods

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
  $0
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
  
}
    OBJC
    assert(ProtocolSnippet.new("UITableViewDelegate").to_s.index(expected))
  end

  should "generate UITableView data source protocol" do
    expected = <<-OBJC
#pragma mark -
#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  $0
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
}
    OBJC
    assert(ProtocolSnippet.new("UITableViewDataSource").to_s.index(expected))
  end
  
  should "not work for unknown protocol" do
    assert_raise(ProtocolSnippetNotSupported) do
      ProtocolSnippet.new("XYZ")
    end
  end
  
  should "have UITableViewDelegate as available protocol" do
    assert(ProtocolSnippet.protocol_definitions["UITableViewDelegate"])
  end
  
  should "have 24 protocol specs for iPhone2.0 & XCode 3.1" do
    assert_equal(24, ProtocolSnippet.protocol_definitions.keys.size, "Only found protocols: #{ProtocolSnippet.protocol_definitions.values.inspect}")
  end
end