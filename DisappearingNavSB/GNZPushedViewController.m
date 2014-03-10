//
//  GNZPushedViewController.m
//  DisappearingNavSB
//
//  Created by Chris Gonzales on 3/10/14.
//  Copyright (c) 2014 GNZ. All rights reserved.
//

#import "GNZPushedViewController.h"

@interface GNZPushedViewController ()

@end

@implementation GNZPushedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect navFrame = self.navigationController.navigationBar.frame;
    self.navigationController.navigationBar.frame = CGRectMake(0, 20, CGRectGetWidth(navFrame), CGRectGetHeight(navFrame));
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
