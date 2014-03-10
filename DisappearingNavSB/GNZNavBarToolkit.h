//
//  GNZNeatScrollViewController.h
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNZNavBarToolkit : UIViewController
-(void)neatScroll:(UIScrollView *)scrollView;
@property (nonatomic) BOOL transitioning;
@property (strong, nonatomic) NSArray *targetNavBarItems;
@end
