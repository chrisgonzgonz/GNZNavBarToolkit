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
@property (strong, nonatomic) UIView *rightBarButtonContainer;
@property (strong, nonatomic) UIButton *rightBarButton;
@property (strong, nonatomic) UIView *barTitleContainer;
@property (strong, nonatomic) UILabel *barTitleLabel;
@property (strong, nonatomic) UIView *leftBarButtonContainer;
@property (strong, nonatomic) UIButton *leftBarButton;
@property (strong, nonatomic) NSArray *buttonList;
@property (strong, nonatomic) NSArray *containerList;

@end

@implementation GNZShakaTableViewController
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
    [titleLabel setCenter:CGPointMake(self.rightBarButtonContainer.frame.size.width / 2, self.rightBarButtonContainer.frame.size.height / 2)];
    [titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setText:@"TitleTitleTitleTitleTitleTitleTitleTitleTitle"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    self.barTitleLabel = titleLabel;
    self.navigationItem.titleView = self.barTitleLabel;
    
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

# define kStatusBarHeight 20
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset = scrollView.contentOffset.y;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    
    NSLog(@"ContentOffset: %f, NavbarFrameOrigin: %f",offset,navBarFrame.origin.y);
    
    CGFloat headerRemains = navBarFrame.origin.y + navBarFrame.size.height - kStatusBarHeight;
//    CGFloat paddingTop = kStatusBarHeight+headerHeight;
    
    if (offset<=-64) { // everything back to normal
        
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, kStatusBarHeight, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;

        for (UIView *view in self.buttonList) {
            view.alpha = 1;
        }
//        self.rightBarButton.alpha = 1;
        
//        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                    [[UIColor blackColor] colorWithAlphaComponent:1],
//                                                    NSForegroundColorAttributeName,
//                                                    [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
//                                                    NSFontAttributeName,
//                                                    nil]];
        for (UIView *view in self.buttonList) {
            view.transform = CGAffineTransformMakeScale(1, 1);
        }
        
//        self.rightBarButton.transform = CGAffineTransformMakeScale(1, 1);

        for (UIView *view in self.containerList) {
            CGRect buttonContainerFrame = view.frame;
            buttonContainerFrame.origin.y = 0;
            view.frame = buttonContainerFrame;
        }
 
//        CGRect buttonContainerFrame = self.rightBarButton.frame;
//        buttonContainerFrame.origin.y = 0;
//        self.rightBarButton.frame = buttonContainerFrame;
        
    } else if (offset/2>-64 && offset<=-20) {
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, -navBarFrame.size.height-offset, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;
        
//        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                         [[UIColor blackColor] colorWithAlphaComponent:headerRemains/navBarFrame.size.height],
//                                                                         NSForegroundColorAttributeName,
//                                                                         [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
//                                                                         NSFontAttributeName,
//                                                                         nil]];
        for (UIView *view in self.buttonList) {
            view.alpha = headerRemains/navBarFrame.size.height;;
        }

        for (UIView *view in self.buttonList) {
            view.transform = CGAffineTransformMakeScale(1-(offset+64)/2/44, 1-(offset+64)/2/44);
        }
        
//        self.rightBarButton.transform = CGAffineTransformMakeScale(1-(offset+64)/2/44, 1-(offset+64)/2/44);

//        self.rightBarButton.alpha = headerRemains/navBarFrame.size.height;

        for (UIView *view in self.containerList) {
            CGRect buttonContainerFrame = view.frame;
            buttonContainerFrame.origin.y = (offset+64)/2;
            view.frame = buttonContainerFrame;
        }
        
//        CGRect buttonContainerFrame = self.rightBarButton.frame;
//        buttonContainerFrame.origin.y = (offset+64)/2;
//        self.rightBarButton.frame = buttonContainerFrame;
        
    } else { // header completely gone
        CGRect tempRect = CGRectMake(navBarFrame.origin.x, kStatusBarHeight-navBarFrame.size.height, navBarFrame.size.width, navBarFrame.size.height);
        self.navigationController.navigationBar.frame = tempRect;

//        [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                                         [[UIColor blackColor] colorWithAlphaComponent:0],
//                                                                         NSForegroundColorAttributeName,
//                                                                         [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
//                                                                         NSFontAttributeName,
//                                                                         nil]];
//
//        self.profileTable.frame = CGRectMake(collectionViewFrame.origin.x, paddingTop-headerHeight, collectionViewFrame.size.width, screenFrame.size.height-paddingTop+headerHeight);
        for (UIView *view in self.buttonList) {
            view.transform = CGAffineTransformMakeScale(0, 0);
        }
        
//        self.rightBarButton.transform = CGAffineTransformMakeScale(0, 0);
        

//        self.buttView.frame = CGRectMake(0, 0, self.buttView.frame.size.width, self.buttView.frame.size.height);
        
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
