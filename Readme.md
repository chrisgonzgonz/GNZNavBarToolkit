GNZNavBarToolkit
================
GNZNavBarToolkit is (at present) a UITableViewController subclass that dynamically shrinks and expands the standard UINavigationBar and UINavigationItems, producing an "Instagram-style" navbar.

Setup
=====
+ Clone this repo
+ Add the `GNZNavBarToolkit` folder to your project
+ Import `GNZNavBarToolkit.h` in the header file of your `UITableViewController`
+ Make `GNZNavBarToolkit` your UITableViewController's superclass

Usage
=====
+ Implement `UIScrollViewDelegate`'s' `scrollViewDidScroll:` method and call `[self neatScroll:scrollView]` as such:
```- (void)scrollViewDidScroll:(UIScrollView *)scrollView
	{
    [self neatScroll:scrollView];
	}```


To Do
=====
+ Release this as a Cocoapod
+ 



