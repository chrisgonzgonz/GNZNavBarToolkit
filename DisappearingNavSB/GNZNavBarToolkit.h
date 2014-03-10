//
//  GNZNeatScrollViewController.h
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/8/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GNZNavBarToolkit : UIViewController


@property (strong, nonatomic) UIView *rightBarButtonContainer;
@property (strong, nonatomic) UIButton *rightBarButton;

@property (strong, nonatomic) UIView *barTitleContainer;
@property (strong, nonatomic) UILabel *barTitleLabel;

@property (strong, nonatomic) UIView *leftBarButtonContainer;
@property (strong, nonatomic) UIButton *leftBarButton;

@property (strong, nonatomic) NSArray *buttonList;
@property (strong, nonatomic) NSArray *containerList;

-(void)neatScroll:(UIScrollView *)scrollView;
@end
