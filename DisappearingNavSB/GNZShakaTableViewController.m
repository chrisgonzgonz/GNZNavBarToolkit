//
//  GNZShakaTableViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZShakaTableViewController.h"

@interface GNZShakaTableViewController ()

@end

@implementation GNZShakaTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

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

# define kStatusBarHeight 20
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // this should not be here lulz
//    AUAuraTitleCell *titleCell = [self.profileTable dequeueReusableCellWithIdentifier:@"auraHeaderCell"];
//    
//    CGRect collectionViewFrame = self.profileTable.frame;
//    CGRect subheaderFrame = titleCell.frame;
//    CGRect headerFrame = self.headerBar.frame;
//    CGRect screenFrame = self.view.frame;
//    
//    CGFloat headerHeight = headerFrame.size.height;
//    CGFloat subHeaderHeight = subheaderFrame.size.height;
    CGFloat offset = scrollView.contentOffset.y;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGFloat adjustedOffset = offset;
    
    NSLog(@"ContentOffset: %f, NavbarFrameHeight: %f",offset,navBarFrame.origin.y);
    
    CGFloat headerRemains = navBarFrame.origin.y + navBarFrame.size.height - kStatusBarHeight;
//    CGFloat paddingTop = kStatusBarHeight+headerHeight;
    
    if (adjustedOffset<=-64) { // everything back to normal
        
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, kStatusBarHeight, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;
//        for (UIView *subview in self.navigationController.navigationBar.subviews) subview.alpha = 1;
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [[UIColor blackColor] colorWithAlphaComponent:1],
                                                    NSForegroundColorAttributeName,
                                                    [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                                    NSFontAttributeName,
                                                    nil]];
        
        NSLog(@"Bar Tint: %@", [[self.navigationController.navigationBar barTintColor] description]);
//
//        self.profileTable.frame = CGRectMake(collectionViewFrame.origin.x, paddingTop, collectionViewFrame.size.width, screenFrame.size.height-paddingTop);
//        
//        self.headerImage.transform = CGAffineTransformMakeScale(1, 1);
//        
//        CGRect imgContainerFrame = self.headerImageContainer.frame;
//        imgContainerFrame.origin.y = 0;
//        self.headerImageContainer.frame = imgContainerFrame;
        
    } else if (offset/2>-64 && offset<=-20) {
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, -navBarFrame.size.height-adjustedOffset, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;
        
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [[UIColor blackColor] colorWithAlphaComponent:headerRemains/navBarFrame.size.height],
                                                                         NSForegroundColorAttributeName,
                                                                         [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                                                         NSFontAttributeName,
                                                                         nil]];
//        for (UIView *subview in self.navigationController.navigationBar.subviews) subview.alpha = headerRemains/headerHeight;
//
//        self.profileTable.frame = CGRectMake(collectionViewFrame.origin.x, paddingTop-adjustedOffset/2, collectionViewFrame.size.width, screenFrame.size.height-paddingTop+adjustedOffset/2);
//        
//        self.headerImage.transform = CGAffineTransformMakeScale(1-offset/2/headerFrame.size.height, 1- offset/2/headerFrame.size.height);
//        
//        CGRect imgContainerFrame = self.headerImageContainer.frame;
//        imgContainerFrame.origin.y = offset/4;
//        self.headerImageContainer.frame = imgContainerFrame;
        
    } else { // header completely gone
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, kStatusBarHeight-navBarFrame.size.height, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;
//        for (UIView *subview in self.navigationController.navigationBar.subviews) subview.alpha = 0;
        self.navigationItem.titleView.alpha = 0;
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                         [[UIColor blackColor] colorWithAlphaComponent:0],
                                                                         NSForegroundColorAttributeName,
                                                                         [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                                                         NSFontAttributeName,
                                                                         nil]];
//
//        self.profileTable.frame = CGRectMake(collectionViewFrame.origin.x, paddingTop-headerHeight, collectionViewFrame.size.width, screenFrame.size.height-paddingTop+headerHeight);
//        self.headerImage.transform = CGAffineTransformMakeScale(0, 0);
    }
    
    // "if nothing pinches the purple thing, don't do shit" - MJones
//    if (headerFrame.origin.y >= kStatusBarHeight) { // hardcoding again lol
//        self.headerImage.transform = CGAffineTransformMakeScale(1, 1);
//        CGRect imgContainerFrame = self.headerImageContainer.frame;
//        imgContainerFrame.origin.y = 0;
//        self.headerImageContainer.frame = imgContainerFrame;
//    }
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
