//
//  GNZShakaTableViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZDemoTableViewController.h"

@interface GNZDemoTableViewController () <UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *targetNavBarItems;
@property (nonatomic) BOOL transitioning;

@end

@implementation GNZDemoTableViewController
static const CGFloat StatusBarHeight = 20.0;


-(void)viewDidLoad
{
    [super viewDidLoad];
    
//  Set delegates
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UIButton *rightButton = [self setUpRightNavButton];
    UIButton *leftButton = [self setUpLeftNavButton];
    UILabel *titleLabel = [self setUpNavTitleLabel];
    
    self.targetNavBarItems = @[rightButton, leftButton, titleLabel];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.transitioning = NO;
}

#pragma mark - Set up buttons and their containers programmatically

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

-(UIButton *)setUpLeftNavButton
{
    UIView *leftBarButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = CGRectMake(0, 0, 32, 32);
    [leftBarButton setTitle:@"\u2705" forState:UIControlStateNormal];
    [leftBarButtonContainer addSubview:leftBarButton];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButtonContainer];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    return leftBarButton;
}

-(UILabel *)setUpNavTitleLabel
{
    UIView *barTitleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:@"Title"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [barTitleContainer addSubview: titleLabel];
    
    self.navigationItem.titleView = barTitleContainer;
    
    return titleLabel;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text = @"HI";
    return cell;
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"SCROLLING: %@", self);
    
    CGFloat offset = scrollView.contentOffset.y;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGFloat headerRemains = navBarFrame.origin.y + navBarFrame.size.height - StatusBarHeight;
    CGFloat lowerBounds = -CGRectGetHeight(navBarFrame)-StatusBarHeight;
    CGFloat upperBounds = -StatusBarHeight;
    
    NSLog(@"ContentOffset: %f, NavbarFrameOrigin: %f",offset,navBarFrame.origin.y);
    
    if (!self.transitioning) {
        if (offset<=lowerBounds) { // everything back to normal
            
            //        Change navbar appearance; navbar is back to original size
            CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame), StatusBarHeight, CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
            self.navigationController.navigationBar.frame = newNavFrame;
            
            //        Change alpha on button items/title
            for (UIView *view in self.targetNavBarItems) {
                view.alpha = 1;
            }
            
            //        Transform to shrink/enlarge button items/title
            for (UIView *view in self.targetNavBarItems) {
                view.transform = CGAffineTransformMakeScale(1, 1);
            }
            
            //       Reposition shrinking buttons to allow for background fade effect
            for (UIView *view in self.targetNavBarItems) {
                CGRect buttonOrTitleFrame = view.frame;
                buttonOrTitleFrame.origin.y = 0;
                view.frame = buttonOrTitleFrame;
            }
            
        } else if (offset/2>lowerBounds && offset<=upperBounds) {
            //        Change navbar appearance
            CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame), -CGRectGetHeight(navBarFrame)-offset, CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
            self.navigationController.navigationBar.frame = newNavFrame;
            
            //        Change alpha on button items/title
            for (UIView *view in self.targetNavBarItems) {
                view.alpha = headerRemains/navBarFrame.size.height;;
            }
            
            //        Transform to shrink/enlarge button items/title
            for (UIView *view in self.targetNavBarItems) {
                view.transform = CGAffineTransformMakeScale(1-(offset+64)/2/44, 1-(offset+64)/2/44);
            }
            
            
            //        Reposition shrinking buttons/title to allow for background fade effect
            for (UIView *view in self.targetNavBarItems) {
                CGRect buttonOrTitleFrame = view.frame;
                buttonOrTitleFrame.origin.y = (offset+64)/2;
                view.frame = buttonOrTitleFrame;
            }
            
        } else { // header completely gone
            //        Change navbar appearance; navbar appears to be behind status bar now
            CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame), StatusBarHeight- CGRectGetHeight(navBarFrame), CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
            self.navigationController.navigationBar.frame = newNavFrame;
            
            //        Transform to shrink button items
            for (UIView *view in self.targetNavBarItems) {
                view.transform = CGAffineTransformMakeScale(0, 0);
            }
            
        }

    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.transitioning = YES;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGRect newNavFrame = CGRectMake(0, 0, CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
    self.navigationController.navigationBar.frame = newNavFrame;
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self neatScroll:scrollView];
//}


@end
