require File.dirname(__FILE__) + "/test_helper"

require "protocol_snippets"

class TestProtocolSnippets < Test::Unit::TestCase
  context "for UITableView" do
    setup do
      @delegate_for = "UITableView"
    end

    should "generate UITableView delegate protocol" do
      expected = <<-OBJC
#pragma mark -
#pragma mark - UITableViewDelegate methods
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
  $0
}

- (NSIndexPath *)tableView:(UITableView *)tableView
                 targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                                      toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{

}

// Optional UITableViewDelegate methods
// Providing Table Cells for the Table View
// – tableView:heightForRowAtIndexPath:
// – tableView:indentationLevelForRowAtIndexPath:
// – tableView:willDisplayCell:forRowAtIndexPath:
// Managing Accessory Views
// – tableView:accessoryTypeForRowWithIndexPath:
// – tableView:accessoryButtonTappedForRowWithIndexPath:
// Managing Selections
// – tableView:willSelectRowAtIndexPath:
// – tableView:didSelectRowAtIndexPath:
// Modifying the Header and Footer of Sections
// – tableView:viewForHeaderInSection:
// – tableView:viewForFooterInSection:
// – tableView:heightForHeaderInSection:
// – tableView:heightForFooterInSection:
// Editing Table Rows
// – tableView:willBeginEditingRowAtIndexPath:
// – tableView:didEndEditingRowAtIndexPath:
// – tableView:editingStyleForRowAtIndexPath:
      OBJC
      assert_equal(expected, ProtocolSnippet.for("UITableViewDelegate"))
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

// Optional UITableViewDataSource methods
// Configuring a Table View
// – numberOfSectionsInTableView:  optional method  
// – sectionIndexTitlesForTableView:  optional method  
// – tableView:sectionForSectionIndexTitle:atIndex:  optional method  
// – tableView:titleForHeaderInSection:  optional method  
// – tableView:titleForFooterInSection:  optional method  
// Inserting or Deleting Table Rows
// – tableView:commitEditingStyle:forRowAtIndexPath:  optional method  
// – tableView:canEditRowAtIndexPath:  optional method  
// Reordering Table Rows
// – tableView:canMoveRowAtIndexPath:  optional method  
// – tableView:moveRowAtIndexPath:toIndexPath:  optional method
      OBJC
      assert_equal(expected, ProtocolSnippet.for("UITableViewDataSource"))
    end
  end
end