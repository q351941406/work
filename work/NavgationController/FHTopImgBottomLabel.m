
//
//  FHTopImgBottomLabel.m
//  Fishing
//
//  Created by pc on 2017/5/5.
//  Copyright © 2017年 linhai. All rights reserved.
//

#import "FHTopImgBottomLabel.h"

@interface FHTopImgBottomLabel()
@property (nonatomic,assign) BOOL isXib;
@end

@implementation FHTopImgBottomLabel

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.isXib = YES;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    

    
    if(self.titleLabel.text && self.imageView.image)
    {
        
        //图片
        CGPoint imageCenter = self.imageView.center;
        imageCenter.x = self.frame.size.width/2;
        imageCenter.y = 30;
        self.imageView.frame = CGRectMake(0, 0, 40, 40);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.imageView.center = imageCenter;
        //文字

        self.titleLabel.frame = CGRectMake(0, 45, self.frame.size.width, _isXib ? 20 : 30);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}

@end




