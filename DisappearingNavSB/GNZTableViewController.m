//
//  GNZTableViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZTableViewController.h"

@interface GNZTableViewController ()

@end

@implementation GNZTableViewController

static const CGFloat kStatusBarHeight = 20.0;

#pragma mark View lifecycle
//  allows for scroll resize/change messages on return/initialization, resets tableview scroll position and navbar when view appears
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.transitioning = NO;
    
    [self scrollTableViewToTop];
}

//  stops scroll resize/change messages in preparation for a new view, reset navbar
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.transitioning = YES;
    
    CGRect navFrame = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(0, kStatusBarHeight, CGRectGetWidth(navFrame), CGRectGetHeight(navFrame));
}

#pragma mark TableView and navbar manipulation

-(void)scrollTableViewToTop
{
    NSIndexPath *topPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:topPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
}

//  Scroll event handler, receives scrollview event and adjusts labels/buttons accordingly
-(void)neatScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;
    CGRect navBarFrame = self.navigationController.navigationBar.frame;
    CGFloat headerRemains = navBarFrame.origin.y + navBarFrame.size.height - kStatusBarHeight;
    CGFloat lowerBounds = -CGRectGetHeight(navBarFrame)-kStatusBarHeight;
    CGFloat upperBounds = -kStatusBarHeight;
    
    NSLog(@"ContentOffset: %f, NavbarFrameOrigin: %f",offset,navBarFrame.origin.y);
    
    if (!self.transitioning) {
        if (offset<=lowerBounds) { // everything back to normal
            
            //        Change navbar appearance; navbar is back to original size
            CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame),
                                            kStatusBarHeight,
                                            CGRectGetWidth(navBarFrame),
                                            CGRectGetHeight(navBarFrame));
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
            CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame),
                                            -CGRectGetHeight(navBarFrame)-offset,
                                            CGRectGetWidth(navBarFrame),
                                            CGRectGetHeight(navBarFrame));
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
            CGRect newNavFrame = CGRectMake(CGRectGetMinX(navBarFrame),
                                            kStatusBarHeight- CGRectGetHeight(navBarFrame),
                                            CGRectGetWidth(navBarFrame),
                                            CGRectGetHeight(navBarFrame));
            self.navigationController.navigationBar.frame = newNavFrame;
            
            //        Transform to shrink button items
            for (UIView *view in self.targetNavBarItems) {
                view.transform = CGAffineTransformMakeScale(0, 0);
            }
            
        }
        
    }
}

@end
