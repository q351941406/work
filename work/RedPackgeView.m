//
//  RedPackgeView.m
//  work
//
//  Created by 林海 on 17/8/13.
//  Copyright © 2017年 pc. All rights reserved.
//

#ifndef SCREEN_WIDTH
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#endif

#ifndef SCREEN_HEIGHT
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#endif

#import "RedPackgeView.h"
#import  <AVFoundation/AVFoundation.h>
#import <Masonry/Masonry.h>
#import <SAMKeychain/SAMKeychain.h>


@interface RedPackgeView()<CAAnimationDelegate>
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *subTitle;
@property (nonatomic, strong) UILabel *desTitle;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UIButton *correntBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isGame;
@property(nonatomic,copy)NSString *msg;
@end

@implementation RedPackgeView


-(id)initWithTitle:(NSString *)title count:(NSInteger)count isGame:(BOOL)isGame
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        self.count = count;
        self.text = title;
        self.isGame = isGame;
        
        [self createUI];
        
        
        BmobQuery   *bquery = [BmobQuery queryWithClassName:@"gameTip"];
        [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            if (error){
                
            }else{
                BmobObject *obj = array.firstObject;
                self.msg = [obj objectForKey:@"msg"];
            }
            
        }];
    }
    return self;
}

-(void)createUI
{
    _coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _coverView.backgroundColor = [UIColor blackColor];
    _coverView.alpha = 0;
    [self addSubview:_coverView];
    
    _redView = [[UIView alloc] init];
    _redView.backgroundColor = KRGB(250, 16, 61, 1);
    _redView.transform = CGAffineTransformMakeScale(0.3, 0.3);
    _redView.alpha = 0;
    [self addSubview:_redView];
    
    CGFloat W = SCREEN_WIDTH - 40;
    CGFloat H = SCREEN_HEIGHT * 0.6;
    
    [_redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.width.mas_equalTo(W);
        make.height.mas_equalTo(H);
    }];
    
    
    UIImageView *hongbao = [[UIImageView alloc] init];
    hongbao.image = [UIImage imageNamed:@"hongbao"];
    [_redView addSubview:hongbao];
    [hongbao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_redView.mas_left);
        make.top.mas_equalTo(_redView.mas_top);
        make.right.mas_equalTo(_redView.mas_right);
        make.bottom.mas_equalTo(_redView.mas_bottom);
    }];

    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _cancelBtn.tintColor = [UIColor whiteColor];
    [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:0];
    [_redView addSubview:_cancelBtn];
    
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_redView.mas_left).offset(4);
        make.top.mas_equalTo(_redView.mas_top).offset (4);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    
    _title = [[UILabel alloc] init];
    _title.font = [UIFont systemFontOfSize:40];
    _title.textColor = [UIColor whiteColor];
    _title.text = @"恭喜您";
    _title.textAlignment = NSTextAlignmentCenter;
    [_redView addSubview:_title];
    
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_redView.mas_left);
        make.right.mas_equalTo(_redView.mas_right);
        make.top.mas_equalTo(_redView.mas_top).offset(40);
    }];
    
    _subTitle = [[UILabel alloc] init];
    _subTitle.font = [UIFont systemFontOfSize:18];
    _subTitle.textColor = [UIColor whiteColor];
    _subTitle.text = self.text;
    _subTitle.textAlignment = NSTextAlignmentCenter;
    [_redView addSubview:_subTitle];
    
    [_subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_redView.mas_left);
        make.right.mas_equalTo(_redView.mas_right);
        make.top.mas_equalTo(_title.mas_bottom).offset(10);
    }];
    
    _numLabel = [[UILabel alloc] init];
    _numLabel.font = [UIFont systemFontOfSize:50];
    _numLabel.textColor = KColor_jin;
    _numLabel.text = self.isGame ? [NSString stringWithFormat:@"%ld",(long)self.count] : @"****";
    _numLabel.textAlignment = NSTextAlignmentCenter;
    [_redView addSubview:_numLabel];
    
    [_numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_redView.mas_left);
        make.right.mas_equalTo(_redView.mas_right);
        make.centerY.mas_equalTo(_redView.mas_centerY).offset(-30);
    }];
    
    CGFloat btnW = 100;
    _correntBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _correntBtn.clipsToBounds = YES;
    _correntBtn.layer.cornerRadius = btnW * 0.5;
    _correntBtn.backgroundColor = [UIColor clearColor];
    [_correntBtn setImage:[UIImage imageNamed:self.isGame ? @"ling" : @"kai"] forState:0];
    [_correntBtn addTarget:self action:@selector(getClick) forControlEvents:UIControlEventTouchUpInside];
    [_redView addSubview:_correntBtn];
    
    [_correntBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_redView.mas_centerX);
        make.centerY.mas_equalTo(_redView.mas_bottom).offset(-140);
        make.width.mas_equalTo(btnW);
        make.height.mas_equalTo(btnW);
    }];
    
    _desTitle = [[UILabel alloc] init];
    _desTitle.font = [UIFont systemFontOfSize:13];
    _desTitle.textColor = [UIColor lightGrayColor];
    _desTitle.text = [NSString stringWithFormat:@"温馨提示: 10000 金币 ＝ 1 元人民币"];
    _desTitle.textAlignment = NSTextAlignmentCenter;
    [_redView addSubview:_desTitle];
    
    [_desTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_redView.mas_left);
        make.right.mas_equalTo(_redView.mas_right);
        make.bottom.mas_equalTo(_redView.mas_bottom).offset(-20);
    }];

}

-(void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _coverView.alpha = 0.5;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.35
                              delay:0
             usingSpringWithDamping:0.5
              initialSpringVelocity:13
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
                                _redView.alpha = 1;
                                _redView.transform = CGAffineTransformIdentity;
                            } completion:nil];
    });

}

-(void)getClick
{
    if ([FHDufulatUtil sharedInstance].network == NO) {
        [SYProgressHUD showToBottomText:@"当前无网络,请先检查网络链接"];
        return;
    }
    
    
    [self haveMoney];
    
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    
    //    CATransform3DMakeRotation(CGFloat angle, CGFloat x, CGFloat y, CGFloat z); 第一个参数是旋转角度，后面三个参数形成一个围绕其旋转的向量，起点位置由UIView的center属性标识。
    theAnimation.values = [NSArray arrayWithObjects:
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0.5, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0, 0.5, 0)],
                           [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0, 0.5, 0)],
                           nil];
    
    
    theAnimation.cumulative = YES;
    //    每个帧的时间=总duration/(values.count - 1)
    // 间隔时间 频率
    theAnimation.duration = 1.2;
    // 重复次数
    theAnimation.repeatCount = 1000;
    
    // 取消反弹// 告诉在动画结束的时候不要移除
    theAnimation.removedOnCompletion = NO;
    // 始终保持最新的效果
    theAnimation.fillMode = kCAFillModeForwards;
    
    theAnimation.delegate = self;
    
    _correntBtn.layer.zPosition = 50;
    [_correntBtn.layer addAnimation:theAnimation forKey:@"transform"];
    
    

}

-(void)haveMoney
{
    WeakSelf;
    
    weakSelf.correntBtn.enabled = NO;
    //查找GameScore表
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"user"];
    [bquery whereKey:@"UUID" equalTo:[SAMKeychain passwordForService:@"UUID" account:@"UUID"]];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error){
            
        }else{
            BmobObject *obj = array.firstObject;
            [obj setObject:@(self.count + [[obj objectForKey:@"Gold"] integerValue]).stringValue forKey:@"Gold"];
            [obj sub_updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                [weakSelf.correntBtn.layer removeAnimationForKey:@"transform"];
            }];
        }
        
    }];
    
}

-(void)cancelClick
{
    [UIView animateWithDuration:0.21 animations:^{
        _redView.transform = CGAffineTransformMakeScale(0.2, 0.2);
        _redView.alpha = 0;
        _coverView.alpha = 0;
    }completion:^(BOOL finished) {
        [_coverView removeFromSuperview];
        [_redView removeFromSuperview];
        [self removeFromSuperview];
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:self.msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alert show];
    }];
    
    if (self.isOpen) {
        if ([self.degelate respondsToSelector:@selector(openRedPackgeViewWithCount:)]) {
            [self.degelate openRedPackgeViewWithCount:self.count];
        }
    }
}

-(void)openMusic
{
    SystemSoundID sound;
    NSString *audioPath = [[NSBundle mainBundle] pathForResource:@"cash_received_coin.caf" ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileUrl, &sound);
    AudioServicesPlaySystemSound(sound);
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.isOpen = YES;
    
    [UIView animateWithDuration:0.1 animations:^{
        self.correntBtn.alpha = 0;
        self.correntBtn.transform = CGAffineTransformMakeScale(10, 10);
    }completion:^(BOOL finished) {
        [self.correntBtn removeFromSuperview];
        
        if (self.isGame) {
            [self openMusic];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self cancelClick];
            });
        }else{
            [_redView layoutIfNeeded];
            [_numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(_redView.mas_centerY).offset(5);
            }];
            [self openMusic];
            [UIView animateWithDuration:0.15
                                  delay:0.1
                 usingSpringWithDamping:0.2
                  initialSpringVelocity:10
                                options:UIViewAnimationOptionCurveEaseOut animations:^{
                                    [_redView layoutIfNeeded];
                                } completion:^(BOOL finished) {
                                    _numLabel.text = [NSString stringWithFormat:@"%ld",(long)self.count];
                                }];
        }
        
       
        
    }];
    
}
@end
