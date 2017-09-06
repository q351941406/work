//
//  CYloginRegisterViewController.m
//  聪颖不聪颖
//
//  Created by 葛聪颖 on 15/9/27.
//  Copyright © 2015年 gecongying. All rights reserved.
//

#import "CYloginRegisterViewController.h"
#import "CYLoginRegisterTextField.h"
#import "GZWTool.h"
#import "GzwHUDTool.h"
#import "GzwThemeTool.h"
@interface CYloginRegisterViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingSpace;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *phone;
@property (weak, nonatomic) IBOutlet CYLoginRegisterTextField *pwd;

@end

@implementation CYloginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    self.loginButton.layer.cornerRadius = 5;
    //    self.loginButton.layer.masksToBounds = YES;
    //    [self.loginButton setValue:@5 forKeyPath:@"layer.cornerRadius"];
    //    [self.loginButton setValue:@YES forKeyPath:@"layer.masksToBounds"];
    //    self.loginButton.clipsToBounds = YES;
    self.view.backgroundColor = [GzwThemeTool backgroudTheme];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (IBAction)login:(id)sender {
    if ([self.phone.text isEqualToString:@"18696004771"] && [self.pwd.text isEqualToString:@"123456789"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isLogin"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }else {
        [GzwHUDTool showErrorWithStatus:@"账号或密码错误"];
    }
}
- (IBAction)register:(id)sender {
    [GzwHUDTool showErrorWithStatus:@"对不起，暂未开放注册，请留意官网通告"];
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)loginOrRegister:(UIButton *)button
{
    // 修改约束
    if (self.leadingSpace.constant == 0) {
        self.leadingSpace.constant = - self.view.width;
//        [button setTitle:@"已有账号？" forState:UIControlStateNormal];
        button.selected = YES;
    }else
    {
        self.leadingSpace.constant = 0;
//        [button setTitle:@"注册账号" forState:UIControlStateNormal];
        button.selected = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}


@end
