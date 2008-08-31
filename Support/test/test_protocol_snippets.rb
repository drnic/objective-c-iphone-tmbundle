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
    assert_equal(expected, ProtocolSnippet.new("UITableViewDelegate").to_s)
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
    assert_equal(expected, ProtocolSnippet.new("UITableViewDataSource").to_s)
  end
  
  should "not work for unknown protocol" do
    assert_raise(ProtocolSnippetNotSupported) do
      ProtocolSnippet.new("XYZ")
    end
  end
  
  should "have UITableViewDelegate as available protocol" do
    assert(ProtocolSnippet.protocol_definitions.include?("UITableViewDelegate"))
  end
end