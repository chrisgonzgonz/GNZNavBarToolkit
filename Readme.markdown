GNZNavBarToolkit
================
GNZNavBarToolkit is a UITableViewController subclass that dynamically shrinks and expands the standard UINavigationBar and UINavigationItems, producing an "Instagram-style" navbar.

Setup
=====
+ Clone this repo
+ Add the `GNZNavBarToolkit` folder to your project
+ Import `GNZNavBarToolkit.h` in the header file of your `UITableViewController`
+ Make `GNZNavBarToolkit` your UITableViewController's superclass

Usage
=====
+ Implement UIScrollViewDelegate's `scrollViewDidScroll:` method and call `[self neatScroll:scrollView]` inside of it. For example:
```objective-c
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  [self neatScroll:scrollView];
}
```

+ Set up your navigation items! Add a `UIButton` or a `UILabel` to a container `UIView` and give both the navigation item and its container view the same frame. Use this container view to create a UIBarButtonItem (demonstrated below) or set this container view as your controller's navigationItem titleView.
+ Add all navigation item buttons/labels to `self.targetNavBarItems` (buttons and labels only, not their container views). GNZNavBarToolkit will only make changes to the UINavigationBar itself and items in this array. The container views are used only as context for navigation item customization. Examples:

```objective-c
-(UIButton *)setUpRightNavButton
{
  UIView *rightBarButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
  UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
  rightBarButton.frame = CGRectMake(0, 0, 32, 32);
  [rightBarButton setTitle:@"\U0001F4CC" forState:UIControlStateNormal];
  [rightBarButtonContainer addSubview:rightBarButton];

  UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonContainer];
  self.navigationItem.rightBarButtonItem = rightButtonItem;

  return rightBarButton;
}
```

```objective-c
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *rightButton = [self setUpRightNavButton];
    UIButton *leftButton = [self setUpLeftNavButton];
    UILabel *titleLabel = [self setUpNavTitleLabel];
    
    self.targetNavBarItems = @[rightButton, leftButton, titleLabel];
}
```

You Might Be Wondering...
=========================
+ Does GNZNavBarToolkit work with Storyboard? Yes it does. You'll have to turn off Auto Layout to have it work correctly 'out of the box', or you can sort out the correct container/button/label constraints. ***Remember to put your buttons/labels into container views with the same sized frame!


To Do
=====
+ Testing
+ 'Out of the box' support for Auto Layout
+ Support for UIScrollview, UICollectionView
+ Release this as a CocoaPod

License
=======
MIT License
-----------
The MIT License (MIT)

Copyright (c) 2013 Andrea Mazzini

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



