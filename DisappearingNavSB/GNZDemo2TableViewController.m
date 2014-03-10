//
//  GNZDemo2TableViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/10/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZDemo2TableViewController.h"

@interface GNZDemo2TableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIView *leftContainer;
@property (weak, nonatomic) IBOutlet UIView *rightContainer;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIView *titleContainer;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation GNZDemo2TableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.leftBarButton = self.leftButton;
    self.leftBarButtonContainer = self.leftContainer;
    self.rightBarButton = self.rightButton;
    self.rightBarButtonContainer = self.rightContainer;
    self.barTitleContainer = self.titleContainer;
    self.barTitleLabel = self.titleLabel;

    self.buttonList = @[self.rightBarButton, self.barTitleLabel, self.leftBarButton];
    self.containerList = @[self.rightBarButtonContainer, self.barTitleContainer, self.leftBarButtonContainer];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    cell.textLabel.text = @"Hello";
    // Configure the cell...
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self neatScroll:scrollView];
}
@end
