//
//  RedPackgeView.h
//  work
//
//  Created by 林海 on 17/8/13.
//  Copyright © 2017年 pc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RedPackgeViewDegelate <NSObject>

-(void)openRedPackgeViewWithCount:(NSInteger)count;

@end

@interface RedPackgeView : UIView

@property (nonatomic,weak) id <RedPackgeViewDegelate> degelate;

-(id)initWithTitle:(NSString *)title count:(NSInteger )count isGame:(BOOL)isGame;

-(void)show;

@end
