//
//  ShareSuccessViewController.m
//  JianGuo
//
//  Created by apple on 17/7/7.
//  Copyright © 2017年 ningcol. All rights reserved.
//

#import "ShareSuccessViewController.h"




@interface ShareSuccessViewController ()

@end

@implementation ShareSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WHITECOLOR;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = WHITECOLOR;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.view.backgroundColor = WHITECOLOR;
}

- (IBAction)share:(id)sender {
    UIButton *btn = sender;
    
    [self shareCommon:btn.tag];

    [self close:nil];
}

-(void)shareCommon:(NSInteger)platformType
{
    
}

- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
