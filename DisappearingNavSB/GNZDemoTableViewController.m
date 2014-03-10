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

@property (strong, nonatomic) UIView *rightBarButtonContainer;
@property (strong, nonatomic) UIButton *rightBarButton;

@property (strong, nonatomic) UIView *barTitleContainer;
@property (strong, nonatomic) UILabel *barTitleLabel;

@property (strong, nonatomic) UIView *leftBarButtonContainer;
@property (strong, nonatomic) UIButton *leftBarButton;

@property (strong, nonatomic) NSArray *buttonList;
@property (strong, nonatomic) NSArray *containerList;

@end

@implementation GNZDemoTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//Right Bar Button
    self.rightBarButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setTitle:@"\U0001F4CC" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rightBarButton = button;
    [self.rightBarButtonContainer addSubview:self.rightBarButton];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarButtonContainer];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
//Title Label
    self.barTitleContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 32)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setText:@"Title"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.barTitleLabel = titleLabel;
    [self.barTitleContainer addSubview: self.barTitleLabel];
    self.navigationItem.titleView = self.barTitleContainer;
    
//Left Bar Button
    self.leftBarButtonContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 32, 32);
    [button setTitle:@"\u2705" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.leftBarButton = button;
    [self.leftBarButtonContainer addSubview:self.leftBarButton];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftBarButtonContainer];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
//Collect Views for bulk adjustments
    self.buttonList = @[self.rightBarButton, self.barTitleLabel, self.leftBarButton];
    self.containerList = @[self.rightBarButtonContainer, self.barTitleContainer, self.leftBarButtonContainer];
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
    static const CGFloat StatusBarHeight = 20.0;
    
    CGFloat offset = scrollView.contentOffset.y;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGFloat headerRemains = navBarFrame.origin.y + navBarFrame.size.height - StatusBarHeight;
    CGFloat lowerBounds = -CGRectGetHeight(navBarFrame)-StatusBarHeight;
    CGFloat upperBounds = -StatusBarHeight;
    
    NSLog(@"ContentOffset: %f, NavbarFrameOrigin: %f",offset,navBarFrame.origin.y);
    
    
    if (offset<=lowerBounds) { // everything back to normal
        
//        Change navbar appearance; navbar is back to original size
        CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame), StatusBarHeight, CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
        self.navigationController.navigationBar.frame = newNavFrame;

//        Change alpha on button items/title
        for (UIView *view in self.buttonList) {
            view.alpha = 1;
        }

//        Transform to shrink/enlarge button items/title
        for (UIView *view in self.buttonList) {
            view.transform = CGAffineTransformMakeScale(1, 1);
        }
        
 //       Reposition shrinking buttons to allow for background fade effect
        for (UIView *view in self.buttonList) {
            CGRect buttonOrTitleFrame = view.frame;
            buttonOrTitleFrame.origin.y = 0;
            view.frame = buttonOrTitleFrame;
        }
        
    } else if (offset/2>lowerBounds && offset<=upperBounds) {
//        Change navbar appearance
        CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame), -CGRectGetHeight(navBarFrame)-offset, CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
        self.navigationController.navigationBar.frame = newNavFrame;

//        Change alpha on button items/title
        for (UIView *view in self.buttonList) {
            view.alpha = headerRemains/navBarFrame.size.height;;
        }

//        Transform to shrink/enlarge button items/title
        for (UIView *view in self.buttonList) {
            view.transform = CGAffineTransformMakeScale(1-(offset+64)/2/44, 1-(offset+64)/2/44);
        }
        

//        Reposition shrinking buttons/title to allow for background fade effect
        for (UIView *view in self.buttonList) {
            CGRect buttonOrTitleFrame = view.frame;
            buttonOrTitleFrame.origin.y = (offset+64)/2;
            view.frame = buttonOrTitleFrame;
        }
        
    } else { // header completely gone
//        Change navbar appearance; navbar appears to be behind status bar now
        CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame), StatusBarHeight- CGRectGetHeight(navBarFrame), CGRectGetWidth(navBarFrame), CGRectGetHeight(navBarFrame));
        self.navigationController.navigationBar.frame = newNavFrame;
        
//        Transform to shrink button items
        for (UIView *view in self.buttonList) {
            view.transform = CGAffineTransformMakeScale(0, 0);
        }

    }
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self neatScroll:scrollView];
//}


@end