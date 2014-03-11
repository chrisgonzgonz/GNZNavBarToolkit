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
+ Implement UIScrollViewDelegate's `scrollViewDidScroll:` method and call `[self neatScroll:scrollView]` inside of it. For example:
```objective-c
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  [self neatScroll:scrollView];
}
```

+ Set up your navigation items! Add a `UIButton` or a `UILabel` to a container `UIView`. Use this container view to create a UIBarButtonItem (shown below) or set as your controller's navigationItem titleView.
+ Add all navbar buttons/labels to `self.targetNavBarItems`. GNZNavBarToolkit will only make changes to the UINavigationBar and items in this array. The containers are used as context for navigation item customization. Examples:

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
+ Does GNZNavBarToolkit work in Storyboard? Yes it does. You'll have to turn off autolayout to have it work correctly out-of-the-box, or you can sort out the correct container/button/label constraints.


To Do
=====
+ Testing
+ Support (constraints) for Auto Layout
+ Support for UIScrollview, UICollectionView
+ Release this as a Cocoapod



