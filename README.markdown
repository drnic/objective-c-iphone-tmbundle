
## Idea for finding protocol methods

In each docco page, I think the instance method signatures are all within `p.spaceabovemethod` elements.

Not sure yet about required vs optional - perhaps from the Tasks section?

    $('li.tooltip code a').html().replace('&nbsp;',' ')
    
Then get its next sibling (`<span class="task_api_suffix"> optional method</span>`) to check for optionalness