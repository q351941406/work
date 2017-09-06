//
//  UILabel+Extended.m
//  UILabelDemo
//
//  Created by huoqiuliang on 15/8/20.
//  Copyright (c) 2015年 sensetime. All rights reserved.
//

#import "UILabel+Extended.h"

@implementation UILabel (Extended)
- (CGSize)labelWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

@end
