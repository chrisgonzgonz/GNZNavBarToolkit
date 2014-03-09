//
//  GNZShakaTableViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZShakaTableViewController.h"

@interface GNZShakaTableViewController () <UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) CGFloat lastOffset;
@property (strong, nonatomic) UIView *buttView;
@property (strong, nonatomic) UILabel *label;

@end

@implementation GNZShakaTableViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.navigationItem.title = @"NeatView";
    UIBarButtonItem *bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    
    self.buttView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [self.buttView addSubview:self.label];
    [self.label setCenter:CGPointMake(self.buttView.frame.size.width / 2, self.buttView.frame.size.height / 2)];
    self.label.text =  @"\U0001F4CC";
    UIBarButtonItem *custom = [[UIBarButtonItem alloc] initWithCustomView:self.buttView];
    self.navigationItem.rightBarButtonItem = custom;
    NSLog(@"Buttview Center: X%f, Y%f", self.buttView.center.x, self.buttView.center.y);
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
    
    NSLog(@"ContentOffset: %f, NavbarFrameOrigin: %f",offset,navBarFrame.origin.y);
    
    CGFloat headerRemains = navBarFrame.origin.y + navBarFrame.size.height - kStatusBarHeight;
//    CGFloat paddingTop = kStatusBarHeight+headerHeight;
    
    if (offset<=-64) { // everything back to normal
        
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, kStatusBarHeight, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;
//        for (UIView *subview in self.navigationController.navigationBar.subviews) subview.alpha = 1;
        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                    [[UIColor blackColor] colorWithAlphaComponent:1],
                                                    NSForegroundColorAttributeName,
                                                    [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
                                                    NSFontAttributeName,
                                                    nil]];
        
//
//        self.profileTable.frame = CGRectMake(collectionViewFrame.origin.x, paddingTop, collectionViewFrame.size.width, screenFrame.size.height-paddingTop);

        
//        CGPoint anchor = self.buttView.center;
        self.label.transform = CGAffineTransformMakeScale(1, 1);
//        self.buttView.center = anchor;
//
//        CGRect imgContainerFrame = self.headerImageContainer.frame;
//        imgContainerFrame.origin.y = 0;
//        self.headerImageContainer.frame = imgContainerFrame;
        
    } else if (offset/2>-64 && offset<=-20) {
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, -navBarFrame.size.height-offset, navBarFrame.size.width, navBarFrame.size.height);
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
        self.label.transform = CGAffineTransformMakeScale(1-(offset+64)/2/44, 1-(offset+64)/2/44);
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
        
//        CGPoint anchor = self.buttView.center;
        self.label.transform = CGAffineTransformMakeScale(0, 0);
//        self.buttView.center = anchor;
        
//        CGAffineTransform t = CGAffineTransformMakeScale(0, 0);
//        t = CGAffineTransformTranslate(t, self.buttView.frame.size.width/2, self.buttView.frame.size.height/2);
//        self.buttView.transform = t;
                self.buttView.frame = CGRectMake(0, 0, self.buttView.frame.size.width, self.buttView.frame.size.height);
        
    }
    
    // "if nothing pinches the purple thing, don't do shit" - MJones
//    if (headerFrame.origin.y >= kStatusBarHeight) { // hardcoding again lol
//        self.headerImage.transform = CGAffineTransformMakeScale(1, 1);
//        CGRect imgContainerFrame = self.headerImageContainer.frame;
//        imgContainerFrame.origin.y = 0;
//        self.headerImageContainer.frame = imgContainerFrame;
//    }
    
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    self.lastOffset = scrollView.contentOffset.y;
//    NSLog(@"Last decelerating for scroll: %f", self.lastOffset);
//}
//
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    if (decelerate) {
//        self.lastOffset = scrollView.contentOffset.y;
//        NSLog(@"Last offset for scroll: %f", self.lastOffset);
//    }
//}

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [self neatScroll:scrollView];
//}


@end
