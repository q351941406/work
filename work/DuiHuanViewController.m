//
//  DuiHuanViewController.m
//  work
//
//  Created by 林海 on 17/8/19.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "DuiHuanViewController.h"
#import "GzwThemeTool.h"


@interface DuiHuanViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *acount;
@property (weak, nonatomic) IBOutlet UITextField *emial;
@property (strong,nonatomic) NSArray *moneybtns;
@property (weak, nonatomic) IBOutlet UIButton *alipayButton;
@property (weak, nonatomic) IBOutlet UIButton *wePayButton;
@property (weak, nonatomic) IBOutlet UIButton *ershiButton;
@property (weak, nonatomic) IBOutlet UIButton *sishiButton;
@property (weak, nonatomic) IBOutlet UIButton *liushiButton;
@property (weak, nonatomic) IBOutlet UIButton *yibaiButton;
@property (weak, nonatomic) IBOutlet UIButton *tixianButton;
@property (assign,nonatomic) BOOL isGoAppstore;

@property (assign,nonatomic) NSInteger firstCount;
@property (assign,nonatomic) NSInteger secondCount;
@property (assign,nonatomic) NSInteger thirdCount;
@property (assign,nonatomic) NSInteger forthCount;

@property (weak, nonatomic) IBOutlet UILabel *firstTitle;
@property (weak, nonatomic) IBOutlet UILabel *secondTitle;
@property (weak, nonatomic) IBOutlet UILabel *thirdTitle;
@property (weak, nonatomic) IBOutlet UILabel *forthTitle;

@property (nonatomic,assign) NSInteger seletcdTag;
@property(nonatomic,copy)NSString *msg;
@end

@implementation DuiHuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"cashTip"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error){
            
        }else{
            BmobObject *obj = array.firstObject;
            self.msg = [obj objectForKey:@"msg"];
        }
        
    }];
    
    
    self.title = [NSString stringWithFormat:@"金币:%ld",(long)self.jinbi_count];
    

    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti) name:@"applicationWillEnterForeground" object:nil];
    
    

    
    self.moneybtns = @[self.ershiButton,self.sishiButton,self.liushiButton,self.yibaiButton];
    
    for (int i = 0; i < _moneybtns.count; i++) {
        UIButton *btn = _moneybtns[i];
        [btn addTarget:self action:@selector(moneyClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)receiveNoti
{
    if (self.isGoAppstore) {
        NSString *reult = [NSString compareCurrentTime:[FHDufulatUtil sharedInstance].goAppstoreTime];
        NSLog(@"%@",reult);
        
        if ([reult floatValue] >= 30) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您已解锁" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            BmobUser *bUser = [BmobUser currentUser];
            [bUser setObject:@(YES) forKey:@"isGoAppstore"];
            [bUser updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                
            }];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"五星好评解锁" message:@"5星好评即可解锁提现功能" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去评分", nil];
            [alert show];
        }
    }
    self.isGoAppstore = NO;
}



- (IBAction)payClick:(id)sender {
    UIButton *btn = sender;
    if (btn.tag == 1) {
        self.alipayButton.selected = YES;
        self.wePayButton.selected = NO;
    }else{
        self.alipayButton.selected = NO;
        self.wePayButton.selected = YES;
    }
}


- (IBAction)moneyClick:(UIButton *)sender {
    for (int i = 0; i < _moneybtns.count; i++) {
        UIButton *btn2 = _moneybtns[i];
        btn2.selected = NO;
    }
    sender.selected = YES;
    self.seletcdTag = sender.tag - 3;
}


- (IBAction)subMit:(id)sender {
    


    
    NSArray *ary = @[@(self.firstCount),@(self.secondCount),@(self.thirdCount),@(self.forthCount)];
    NSInteger seletedCount = [ary[self.seletcdTag] integerValue];
    
//    if (seletedCount > self.jinbi_count) {
//        [SYProgressHUD showToBottomText:@"金币不够,无法满足兑换条件"];
//        return;
//    }
//    
//    if (_acount.text.length == 0) {
//        [SYProgressHUD showToBottomText:@"请输入账号"];
//        return;
//    }
//    
//    if (_emial.text.length == 0) {
//        [SYProgressHUD showToBottomText:@"请输入昵称"];
//        return;
//    }
    
    
    
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:self.msg message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
    

    
}





@end
