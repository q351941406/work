//
//  NSMutableAttributedString+Extends.m
//  pjh365
//
//  Created by Summer on 16/9/21.
//  Copyright © 2016年 SmileForever. All rights reserved.
//

#import "NSMutableAttributedString+Extends.h"

@implementation NSMutableAttributedString (Extends)

+(instancetype)mutableString:(NSString *)string fontSize:(NSInteger )fontSize fontColor:(UIColor *)fontColor{
    
    return  [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:fontColor}];
}


+ (instancetype)mutableString:(NSString *)string custFontName:(NSString *)fontName fontSize:(NSInteger )fontSize fontColor:(UIColor *)fontColor{
    
    return  [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName:[UIFont fontWithName:fontName size:fontSize],NSForegroundColorAttributeName:fontColor}];
}

- (instancetype)setString:(NSString *)setString fontSize:(NSInteger )fontSize fontColor:(UIColor *)fontColor{
    NSRange range1 = [self.string rangeOfString:setString];
    
    [self setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSForegroundColorAttributeName:fontColor} range:range1];
    return self;
}

@end
