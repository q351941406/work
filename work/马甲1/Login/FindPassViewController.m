//
//  FindPassViewController.m
//  JianGuo
//
//  Created by apple on 16/3/4.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "FindPassViewController.h"
#import "MyTabBarController.h"


#import "JGHTTPClient+LoginOrRegister.h"
#import "TTTAttributedLabel.h"

#import "CodeValidateView.h"
#define SECONDCOUNT 60

@interface FindPassViewController()<UITextFieldDelegate>
{
    int count;
    NSTimer *_timer;
}
@property (nonatomic,strong)IBOutlet UITextField *telTF;

@property (nonatomic,strong) IBOutlet UITextField *passTF;

@property (nonatomic,strong) IBOutlet UITextField *surePassTF;

@property (nonatomic,strong) IBOutlet UITextField *codeTF;

@property (nonatomic,copy) NSString *code;

@property (nonatomic,strong) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *agreementL;

@end

@implementation FindPassViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"密码找回";
    count = SECONDCOUNT;
    
    self.telTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.passTF.leftViewMode = UITextFieldViewModeAlways;
    self.surePassTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.telTF.leftView = [self createLeftViewWithImageName:@"account"];
    self.codeTF.leftView = [self createLeftViewWithImageName:@"verifycode"];
    self.passTF.leftView = [self createLeftViewWithImageName:@"lock"];
    self.surePassTF.leftView = [self createLeftViewWithImageName:@"lock"];
    
    
}

- (IBAction)getCode:(UIButton *)sender {
    
    if (self.telTF.text.length!=11||![self checkTelNumber:self.telTF.text]) {
        [self showAlertViewWithText:@"请输入正确的手机号" duration:1];
        return;
    }
    
    CodeValidateView *view = [CodeValidateView aValidateViewCompleteBlock:^(NSString *code){
        
        [self.getCodeBtn setBackgroundColor:LIGHTGRAYTEXT];
        self.getCodeBtn.userInteractionEnabled = NO;
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSeconds) userInfo:nil repeats:YES];
        
    } withTel:self.telTF.text type:@"2"];
    
    [view show];
    

    
}
- (IBAction)sureCommit:(UIButton *)sender {
    
    if (![self.passTF.text isEqualToString:self.surePassTF.text]){
        [self showAlertViewWithText:@"两次密码不一致" duration:1];
        return;
    }else if (self.passTF.text.length<6){
        [self showAlertViewWithText:@"密码为 6~32 位" duration:1];
        return;
    }
    [SVProgressHUD showWithStatus:@"正在提交...." maskType:SVProgressHUDMaskTypeNone];
    IMP_BLOCK_SELF(FindPassViewController);
    
    [JGHTTPClient alertThePassWordByPhoneNum:self.telTF.text smsCode:self.codeTF.text newPassWord:self.passTF.text Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        [_timer invalidate];
        JGLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 200) {
            
            
            [block_self showAlertViewWithText:@"密码修改成功" duration:1];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
            
        }else{
            [block_self showAlertViewWithText:@"密码修改失败" duration:1];
        }
        
    } failure:^(NSError *error) {
        
        [_timer invalidate];
        [SVProgressHUD dismiss];
        [block_self showAlertViewWithText:NETERROETEXT duration:1];
    }];

    
}
-(UIView *)createLeftViewWithImageName:(NSString *)name
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 45)];
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(17, 13, 16, 18)];
    imgV.image = [UIImage imageNamed:name];
    [view addSubview:imgV];
    return view;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

-(void)changeSeconds
{
    count--;
    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%d S",count] forState:UIControlStateNormal];
    if (count == 0) {
        [_timer invalidate];
        count = SECONDCOUNT;
        [self.getCodeBtn setTitle:@"验证" forState:UIControlStateNormal];
        [self.getCodeBtn setBackgroundColor:GreenColor];
        self.getCodeBtn.userInteractionEnabled = YES;
    }
}

/**
 *  监听textEield的输入
 *
 *  @param textField 输入框
 */
-(IBAction)ensureRightInPut:(UITextField *)textField
{
    if(textField == self.telTF){
        if (self.telTF.text.length>11) {
            self.telTF.text = [self.telTF.text substringToIndex:11];
        }
    }else if (self.passTF.text.length>32){
        self.passTF.text = [self.passTF.text substringToIndex:32];
        [self showAlertViewWithText:@"密码为 6~32 位" duration:1];
    }else if (self.codeTF.text.length>6){
        self.codeTF.text = [self.codeTF.text substringToIndex:6];
        [self showAlertViewWithText:@"验证码为 6 位" duration:1];
    }
}



@end
