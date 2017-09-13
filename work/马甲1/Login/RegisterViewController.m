//
//  RegisterViewController.m
//  JianGuo
//
//  Created by apple on 16/3/3.
//  Copyright © 2016年 ningcol. All rights reserved.
//

#import "RegisterViewController.h"
#import "WebViewController.h"
#import "TTTAttributedLabel.h"
#import "ProfileViewController.h"

#import "CodeValidateView.h"

#import "JGHTTPClient+LoginOrRegister.h"


#define SECONDCOUNT 60

@interface RegisterViewController()<UITextFieldDelegate,TTTAttributedLabelDelegate>
{
    int count;
    NSTimer *_timer;
}
@property (nonatomic,strong)IBOutlet UITextField *telTF;

@property (nonatomic,strong) IBOutlet UITextField *passTF;

@property (nonatomic,strong) IBOutlet UITextField *surePassTF;

@property (nonatomic,strong) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (nonatomic,copy) NSString *code;

@property (nonatomic,strong) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *agreementL;


@end

@implementation RegisterViewController



-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"注册";
    count = SECONDCOUNT;
    
    self.telTF.leftViewMode = UITextFieldViewModeAlways;
    self.codeTF.leftViewMode = UITextFieldViewModeAlways;
    self.passTF.leftViewMode = UITextFieldViewModeAlways;
    self.surePassTF.leftViewMode = UITextFieldViewModeAlways;
    
    self.telTF.leftView = [self createLeftViewWithImageName:@"account"];
    self.codeTF.leftView = [self createLeftViewWithImageName:@"verifycode"];
    self.passTF.leftView = [self createLeftViewWithImageName:@"lock"];
    self.surePassTF.leftView = [self createLeftViewWithImageName:@"lock"];
    
    
    [self.agreementL setText:@"注册账号视为同意《校园用户协议》" afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        
//        [mutableAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(0, mutableAttributedString.length)];//这个设置方式不起作用
        
        [mutableAttributedString addAttributes:@{(id)kCTForegroundColorAttributeName:LIGHTGRAYTEXT} range:NSMakeRange(0, mutableAttributedString.length) ];//NSForegroundColorAttributeName  不能改变颜色 必须用   (id)kCTForegroundColorAttributeName,此段代码必须在前设置
        
        return mutableAttributedString;
    }];
    UIFont *boldSystemFont = [UIFont systemFontOfSize:14];
    CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
    //添加点击事件
    self.agreementL.enabledTextCheckingTypes = NSTextCheckingTypeLink;

    self.agreementL.linkAttributes = @{(NSString *)kCTFontAttributeName:(__bridge id)font,(id)kCTForegroundColorAttributeName:GreenColor};//NSForegroundColorAttributeName  不能改变颜色 必须用   (id)kCTForegroundColorAttributeName,此段代码必须在前设置
    CFRelease(font);
    NSRange range= [self.agreementL.text rangeOfString:@"校园用户协议"];
    
    NSURL* url = [NSURL URLWithString:@"http://101.200.205.243:8080/user_agreement.jsp"];
    [self.agreementL addLinkToURL:url withRange:range];
    

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
- (IBAction)sureRegist:(UIButton *)sender {
    
    if (![self.passTF.text isEqualToString:self.surePassTF.text]){
        [self showAlertViewWithText:@"两次密码不一致" duration:1];
        return;
    }else if (self.passTF.text.length<6){
        [self showAlertViewWithText:@"密码为 6~32 位" duration:1];
        return;
    }
    
    JGSVPROGRESSLOAD(@"注册中, 让信息飞一会儿！");
    
    [JGHTTPClient registerByPhoneNum:self.telTF.text passWord:self.passTF.text code:self.codeTF.text type:@"1" Success:^(id responseObject) {
        
        JGLog(@"%@",responseObject);
        //        [_timer invalidate];
        [SVProgressHUD dismiss];
        [self showAlertViewWithText:responseObject[@"message"] duration:1];
        if ([responseObject[@"code"]integerValue]==200) {
            
            [JGUser saveUser:[JGUser shareUser] WithDictionary:responseObject[@"data"] loginType:LoginTypeByPhone];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{//填写基本资料
                ProfileViewController *profileVC = [[ProfileViewController alloc] init];
                [self.navigationController pushViewController:profileVC animated:YES];
            });
            
        }
        
        
    } failure:^(NSError *error) {
        
        [_timer invalidate];
        [SVProgressHUD dismiss];
        
    }];

    
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
        
    } withTel:self.telTF.text type:@"3"];
    
    [view show];
    
}

-(void)getValidateCode:(NSString *)code
{
    [self.getCodeBtn setBackgroundColor:LIGHTGRAYTEXT];
    self.getCodeBtn.userInteractionEnabled = NO;
    _timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeSeconds) userInfo:nil repeats:YES];
    
    JGSVPROGRESSLOAD(@"正在发送验证码");
    
    IMP_BLOCK_SELF(RegisterViewController);
    
    [JGHTTPClient getAMessageAboutCodeByphoneNum:self.telTF.text type:@"3" imageCode:code Success:^(id responseObject) {
        [SVProgressHUD dismiss];
        JGLog(@"%@",responseObject[@"code"]);
        [self showAlertViewWithText:responseObject[@"message"] duration:1];
        if ([responseObject[@"code"]integerValue]==200) {
            
        }else{
            //                [_timer invalidate];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [block_self.navigationController popViewControllerAnimated:YES];
            });
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [self showAlertViewWithText:NETERROETEXT duration:1];
    }];
}

- (IBAction)unGetCode:(UIButton *)sender {
    
    
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label
   didSelectLinkWithURL:(NSURL *)url
{
    WebViewController *webVC = [[WebViewController alloc] init];
        webVC.title = @"用户协议";
        webVC.url = [NSString stringWithFormat:@"%@",url];
        [self.navigationController pushViewController:webVC animated:YES];
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






@end
