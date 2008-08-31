require File.dirname(__FILE__) + "/test_helper"

require "protocol_snippets"

class TestProtocolSnippets < Test::Unit::TestCase
  should "generate UITableView delegate protocol" do
    expected = <<-OBJC
#pragma mark -
#pragma mark - UITableViewDelegate methods

// Asks the delegate whether the background of the specified row should be indented while the table view is in editing mode.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
  $0
}

// Asks the delegate to return a new index path to retarget a proposed move of a row.
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
  
}
    OBJC
    expected = expected.split("\n")
    actual = ProtocolSnippet.new("UITableViewDelegate").to_s.split("\n")[0..expected.length-1]
    assert_equal(expected, actual,
      "Not matching; generated snippet:\n#{actual}")
  end

  should "generate UITableView data source protocol" do
    expected = <<-OBJC
#pragma mark -
#pragma mark - UITableViewDataSource methods

// Asks the data source for a cell to insert in a particular location of the table view.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  $0
}

// Tells the data source to return the number of rows in a given section of a table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
}
    OBJC
    expected = expected.split("\n")
    actual = ProtocolSnippet.new("UITableViewDataSource").to_s.split("\n")[0..expected.length-1]
    assert_equal(expected, actual,
      "Not matching; generated snippet:\n#{actual}")
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