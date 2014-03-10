//
//  GNZNeatScrollViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZNavBarToolkit.h"

@interface GNZNavBarToolkit ()

@end

@implementation GNZNavBarToolkit

# define kStatusBarHeight 20
-(void)neatScroll:(UIScrollView *)scrollView
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

@end