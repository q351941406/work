//
//  HKNewsButton.m
//  HKNewsBannerView
//
//  Created by Mac on 16/7/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "HKNewsButton.h"

@implementation HKNewsButton
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{}
@end
