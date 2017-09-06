//
//  LoginViewController.m
//  work
//
//  Created by 林海 on 17/8/14.
//  Copyright © 2017年 pc. All rights reserved.
//

#import "LoginViewController.h"
#import "WHGradientHelper.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[WHGradientHelper addGradientChromatoAnimationForLableText:self.view lable:self.titleLabel];
    
    self.loginBtn.layer.cornerRadius = 24;
    self.registerBtn.layer.cornerRadius = 24;
    self.backBtn.layer.cornerRadius = 24;
    
    self.loginBtn.clipsToBounds = YES;
    self.registerBtn.clipsToBounds = YES;
    self.backBtn.clipsToBounds = YES;
    
    self.loginBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.loginBtn.layer.borderWidth = 1;
    self.registerBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.registerBtn.layer.borderWidth = 1;
    self.backBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.backBtn.layer.borderWidth = 1;
    

   // [_userName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
   // [_password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];

    
}

- (IBAction)login:(id)sender {
}

- (IBAction)register:(id)sender {
}

- (IBAction)back:(id)sender {
    
}

@end
