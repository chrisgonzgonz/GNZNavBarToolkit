//
//  GNZTableViewController.h
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNZTableViewController : UITableViewController
-(void)neatScroll:(UIScrollView *)scrollView;
@property (nonatomic) BOOL transitioning;
@property (nonatomic, copy) NSArray *targetNavBarItems;
@end
