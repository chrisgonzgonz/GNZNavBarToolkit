//
//  GNZDemoTableViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZDemoTableViewController.h"

@interface GNZDemoTableViewController ()

@end

@implementation GNZDemoTableViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *rightButton = [self setUpRightNavButton];
    UIButton *leftButton = [self setUpLeftNavButton];
    UILabel *titleLabel = [self setUpNavTitleLabel];
    
    self.targetNavBarItems = @[rightButton, leftButton, titleLabel];
}

#pragma mark - Set up buttons and their containers programmatically

-(UIButton *)setUpRightNavButton
{
    CGRect rightBarButtonFrame = CGRectMake(0, 0, 32, 32);
    UIView *rightBarButtonContainer = [[UIView alloc] initWithFrame:rightBarButtonFrame];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBarButton.frame = rightBarButtonFrame;
    [rightBarButton setTitle:@"\U0001F4CC" forState:UIControlStateNormal];
    [rightBarButtonContainer addSubview:rightBarButton];
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButtonContainer];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    return rightBarButton;
}

-(UIButton *)setUpLeftNavButton
{
    CGRect leftBarButtonFrame = CGRectMake(0, 0, 32, 32);
    UIView *leftBarButtonContainer = [[UIView alloc] initWithFrame:leftBarButtonFrame];
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBarButton.frame = leftBarButtonFrame;
    [leftBarButton setTitle:@"\u2705" forState:UIControlStateNormal];
    [leftBarButtonContainer addSubview:leftBarButton];
    
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButtonContainer];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    return leftBarButton;
}

-(UILabel *)setUpNavTitleLabel
{
    CGRect titleLabelFrame = CGRectMake(0, 0, 200, 32);
    UIView *barTitleContainer = [[UIView alloc] initWithFrame:titleLabelFrame];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
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
    cell.textLabel.text = @"Hi!";
    return cell;
}

#pragma mark - Scroll view delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self neatScroll:scrollView];
}





@end
