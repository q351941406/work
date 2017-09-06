//
//  gameBtn.m
//  work
//
//  Created by 林海 on 17/8/14.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "DuihuanButton.h"
@interface DuihuanButton()
@property (nonatomic,strong) UIView *selectedView;
@end

@implementation DuihuanButton

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _selectedView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        _selectedView.hidden = !self.selected;
        _selectedView.backgroundColor = [UIColor redColor];
        [self addSubview:_selectedView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _selectedView.frame = CGRectMake(self.width * 0.5 - 10, self.height - 5, 20, 1);
}

-(void)setHighlighted:(BOOL)highlighted{
    
}

-(void)setSelected:(BOOL)selected
{
    self.selectedView.hidden = !selected;
}
@end
