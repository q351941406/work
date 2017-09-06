//
//  FHJiangLiView.m
//  work
//
//  Created by 林海 on 17/8/19.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "FHJiangLiView.h"

@interface FHJiangLiView()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation FHJiangLiView

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//    self.closeButton.layer.borderColor = KRGB(252, 202, 95, 1).CGColor;
//    self.closeButton.layer.borderWidth = 3;
//    self.closeButton.layer.cornerRadius = 4;
//    self.closeButton.clipsToBounds = YES;
    
    
    
    [self.button1 setTitle: [NSString stringWithFormat:@"%ld/10",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    [self.button2 setTitle: [NSString stringWithFormat:@"%ld/50",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    [self.button3 setTitle: [NSString stringWithFormat:@"%ld/100",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    [self.button4 setTitle: [NSString stringWithFormat:@"%ld/200",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    [self.button5 setTitle: [NSString stringWithFormat:@"%ld/300",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    [self.button6 setTitle: [NSString stringWithFormat:@"%ld/400",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    [self.button7 setTitle: [NSString stringWithFormat:@"%ld/500",(long)[FHDufulatUtil sharedInstance].shenglicount] forState:0];
    
    NSArray *btns = @[self.button1,self.button2,self.button3,self.button4,self.button5,self.button6,self.button7];

    
    NSInteger count =  [FHDufulatUtil sharedInstance].shenglicount;
    
    NSArray *ary = @[@(10),@(50),@(100),@(200),@(300),@(400),@(500)];

    for (int i = 0; i < 7; i++) {
        NSInteger kkk = [ary[i] integerValue];
        UIButton *btn = btns[i];
        btn.tag = i;
        if (count >= kkk) {
            if ([[FHDufulatUtil sharedInstance]getBoolWithKey:[NSString stringWithFormat:@"%d",i]]) {
                [btn setTitle:@"已领取" forState:0];
                btn.userInteractionEnabled = NO;
            }else{
                [btn setBackgroundColor:KColor_blue];
                [btn setTitle:@"   领取   " forState:0];
                [btn setTitleColor:[UIColor whiteColor] forState:0];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            }
        }else{
            btn.userInteractionEnabled = NO;
        }
        
    }
    
}

- (IBAction)closeClick:(id)sender {
    [self removeFromSuperview];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jiangliRemove" object:nil];
}

-(void)btnClick:(UIButton *)btn
{
    
    if ([FHDufulatUtil sharedInstance].network == NO) {
        [SYProgressHUD showToBottomText:@"当前无网络,请先检查网络链接"];
        return;
    }
    
    
    NSArray *ary = @[@(50),@(100),@(200),@(400),@(700),@(1000),@(1500)];
    
    NSInteger count = [ary[btn.tag] integerValue];
    [btn setTitle:@"已领取" forState:0];
    [btn setTitleColor:[UIColor lightGrayColor] forState:0];
    btn.backgroundColor = [UIColor whiteColor];
    btn.userInteractionEnabled = NO;
    
    [SYProgressHUD showLoadingWindowText:@"请稍后"];
    BmobUser *bUser = [BmobUser currentUser];
    [bUser setObject:@(self.jinbi_count + count) forKey:@"money"];
    [bUser setObject:[NSString getCurrentTime] forKey:@"mytime"];
    [bUser sub_updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        [SYProgressHUD hide];
        [SYProgressHUD showToBottomText:[NSString stringWithFormat:@"已获得%ld个金币",(long)count]];
        [[FHDufulatUtil sharedInstance] setBool:YES indexkey:[NSString stringWithFormat:@"%ld",(long)btn.tag]];
    }];
}

@end
