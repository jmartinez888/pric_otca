BasicPagination class

Features:

- Easy to use, multi purpose, easily extendable
- High and low level usage
- Support for multiple languages
- Automatic handling of URL parameters
- Multiple simultaneous paginators 
- Variable width requirements (narrow/wide view)

instantiation:

You must provide the total number of items so that the total number of pages can be calculated.

$P = new BasicPagination($TotalItemCount);                        # specify the total number of items
$P = new BasicPagination($TotalItemCount,'target.php?');          # specify href prefix
$P = new BasicPagination($TotalItemCount,'?',20);                 # 20 items per page (default 10)
$P = new BasicPagination($TotalItemCount,'?',10,'o2');            # alternate offset parameter name
$P = new BasicPagination($TotalItemCount,'?',10,'offset',false);  # non-sticky URL parameters

properties:

All properties can be read and modified directly after instantiation. 
Properties 'link_class' and 'anchor' must be set after instantiation if they are to be used.

$P->max                   # the max offset value, equals $TotalItemCount
$P->baseurl               # prefix for all href attrs, default '?' 
$P->itemcount             # number of items per page, default 10
$P->offset_param_name     # name of URL parameter carrying offset, default 'offset'
$P->offset                # current offset, automatically read from $_REQUEST
$P->sticky                # stickyness of URL parameters, default true
$P->unstick               # array of URL parameter names to NOT use in links
$P->link_class            # class to be added to all links, default '' (none)
$P->anchor                # anchor to append to all links, default '' (none) 

High level methods:

$P->UnStick('foo');       # Drop URL parameter foo when making links
$P->PagesHTML();          # Returns the HTML page links
$P->PagesHTML(40);        # wide screen, up to 40 page links
$P->PagesHTML(12);        # narrow screen, max 12 page links
$P->PagesHTML(12,' - ');  # dash separator

Lower level methods:

$P->pagelinks()                   # returns page links only (not first/last/prev/next)
$P->make_URL($offset)             # returns an URL for use in a HREF or similar
$P->pagelink($page,$Label=false)  # returns a single page link
$P->firstpage()                   # link to the first page
$P->lastpage()                    # link to the last page
$P->nextpage()                    # link to the next page 
$P->prevpage()                    # link to the previous page

Methods meant for overriding:

$P->Label($i)       # Alternative text on page links, see demo
$P->Translate($str) # Implement your translations here, or trough a function named "translate"
$P->PagesHTML()     # Override to change link layout: first - prev - ..... - next - last
