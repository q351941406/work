//
//  gameBtn.m
//  work
//
//  Created by 林海 on 17/8/14.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "gameBtn.h"
@interface gameBtn()
@property (nonatomic,strong) UIView *selectedView;
@end

@implementation gameBtn

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _selectedView.hidden = YES;
        _selectedView.backgroundColor = [UIColor redColor];
        [self addSubview:_selectedView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.transform = CGAffineTransformIdentity;
    CGAffineTransform form = CGAffineTransformMakeScale(0.8, 0.8);
    self.imageView.transform = CGAffineTransformRotate(form, 150);
    
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

-(void)setSelected:(BOOL)selected
{
    self.selectedView.hidden = !selected;
    
}
@end
