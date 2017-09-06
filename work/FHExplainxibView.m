//
//  FHExplainxibView.m
//  work
//
//  Created by 林海 on 17/8/18.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "FHExplainxibView.h"
@interface FHExplainxibView()
@property (weak, nonatomic) IBOutlet UIView *backViewd;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation FHExplainxibView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backViewd.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//    self.closeButton.layer.borderColor = KRGB(252, 202, 95, 1).CGColor;
//    self.closeButton.layer.borderWidth = 3;
//    self.closeButton.layer.cornerRadius = 4;
//    self.closeButton.clipsToBounds = YES;
    
    
}

- (IBAction)removeClick:(id)sender {
    [self removeFromSuperview];
}

@end
