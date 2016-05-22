//
//  WSLoginViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSLoginViewController.h"
#import "WSRegViewController.h"

@interface WSLoginViewController ()
@property (weak, nonatomic) UIView *inputBgView;
@property (weak, nonatomic) UITextField *userNameTextField;
@property (weak, nonatomic) UITextField *passwordTextField;


@end
@implementation WSLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - 初始化界面
- (void)setUpView {
    
    [self creatTopBar];
    [self creatNavBackButton];
    [self setUpTopBar];
    [self creatInputView];
    [self creatButtons];
    
    self.view.backgroundColor = RGBColor(0xfc, 0xfc, 0xfc);
}

- (void)setUpTopBar {
    
    self.title = @"登录";
    
    self.topBarBgColor = RGBColor(0xff, 0xff, 0xff);
    self.titleColor = RGBColor(0x42, 0x42, 0x42);
    self.backBlackArrow = YES;
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGBColor(0xbe, 0xbc, 0xbd);
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(0.5);
    }];
    
    //    UIButton *forgetPasswordButton = [[UIButton alloc] init];
    //    forgetPasswordButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [forgetPasswordButton setTitle:@"找回密码？" forState:UIControlStateNormal];
    //    [forgetPasswordButton setTitleColor:ZhangYuRed forState:UIControlStateNormal];
    //    [self.view addSubview:forgetPasswordButton];
    //    [forgetPasswordButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(self.view).offset(-5);
    //        make.top.equalTo(self.view).offset(30);
    //        make.size.mas_equalTo(CGSizeMake(70, 25));
    //    }];
}


- (void)creatInputView {
    
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"login_logo"];
    [self.view addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64 + 17);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    
    UIView *inputBgView = [[UIView alloc] init];
    inputBgView.backgroundColor = [UIColor whiteColor];
    inputBgView.layer.borderWidth = 1;
    inputBgView.layer.borderColor = RGBColor(0xe7, 0xe7, 0xe7).CGColor;
    inputBgView.layer.cornerRadius = 5;
    [self.view addSubview:inputBgView];
    self.inputBgView = inputBgView;
    [inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(logoImageView.mas_bottom).offset(17);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(90);
    }];
    
    UIView *middleLineView = [[UIView alloc] init];
    middleLineView.backgroundColor = RGBColor(0xe7, 0xe7, 0xe7);
    [inputBgView addSubview:middleLineView];
    [middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inputBgView);
        make.centerY.equalTo(inputBgView);
        make.height.mas_equalTo(0.5);
    }];
    
    UITextField *userNameTextField = [[UITextField alloc] init];
    userNameTextField.delegate = self;
    userNameTextField.placeholder = @"手机号码/邮箱/昵称";
    userNameTextField.font = [UIFont systemFontOfSize:15];
    userNameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    userNameTextField.returnKeyType = UIReturnKeyNext;
    userNameTextField.enablesReturnKeyAutomatically = YES;
    UIImageView *userNameImageView = [[UIImageView alloc] init];
    userNameImageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeLeft;
    userNameImageView.frame = CGRectMake(0, 0, 25, 25);
    userNameImageView.image = [UIImage imageNamed:@"login_username"];
    userNameTextField.leftView = userNameImageView;
    userNameTextField.leftViewMode = UITextFieldViewModeAlways;
    [inputBgView addSubview:userNameTextField];
    self.userNameTextField = userNameTextField;
    [userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(inputBgView).offset(15);
        make.right.equalTo(inputBgView).offset(-15);
        make.bottom.equalTo(middleLineView.mas_top);
        make.top.equalTo(inputBgView);
    }];
    
    UITextField *passwordTextField = [[UITextField alloc] init];
    passwordTextField.delegate = self;
    passwordTextField.placeholder = @"请输入密码";
    passwordTextField.font = userNameTextField.font;
    passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    passwordTextField.secureTextEntry = YES;
    passwordTextField.returnKeyType = UIReturnKeyJoin;
    passwordTextField.enablesReturnKeyAutomatically = YES;
    UIImageView *passwordImageView = [[UIImageView alloc] init];
    passwordImageView.contentMode = UIViewContentModeScaleAspectFit | UIViewContentModeLeft;
    passwordImageView.frame = CGRectMake(0, 0, 25, 25);
    passwordImageView.image = [UIImage imageNamed:@"login_password"];
    passwordTextField.leftView = passwordImageView;
    passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    [inputBgView addSubview:passwordTextField];
    self.passwordTextField = passwordTextField;
    [passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleLineView.mas_bottom);
        make.left.equalTo(userNameTextField);
        make.right.equalTo(userNameTextField);
        make.bottom.equalTo(inputBgView);
    }];
    
    if (!(SYSTEM_VERSION_NEWER_OR_EQUAL_TO_8)) {
        userNameTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        passwordTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
}

- (void)creatButtons {
    
    UIButton *loginButton = [[UIButton alloc] init];
    loginButton.layer.cornerRadius = 5;
    loginButton.backgroundColor = RGBColor(0xe8, 0x1f, 0x56);
    loginButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.view addSubview:loginButton];
    [loginButton addTarget:self action:@selector(loginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputBgView.mas_bottom).offset(14);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(44);
    }];
    
//    WSOAuthLoginView *oAuthView = [[WSOAuthLoginView alloc] initWithVC:self];
//    [self.view addSubview:oAuthView];
//    [oAuthView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(loginButton.mas_bottom).offset(32);
//        make.left.right.equalTo(loginButton);
//        make.height.mas_equalTo(45);
//    }];
    
    UIButton *registButton = [[UIButton alloc] init];
    registButton.layer.borderColor = loginButton.backgroundColor.CGColor;
    registButton.layer.borderWidth = 1;
    registButton.layer.cornerRadius = 5;
    [registButton setTitle:@"注册帐号" forState:UIControlStateNormal];
    [registButton setTitleColor:loginButton.backgroundColor forState:UIControlStateNormal];
    registButton.titleLabel.font = loginButton.titleLabel.font;
    [self.view addSubview:registButton];
    [registButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-19);
        make.size.mas_equalTo(CGSizeMake(106, 32));
    }];
    __weak __typeof(&*self)weakSelf = self;
    [registButton addActionHandler:^(NSInteger tag) {
        WSRegViewController * registVC = [[WSRegViewController alloc]init];
        registVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:registVC animated:YES];
    }];
}
#pragma mark - 登录按钮点击
- (void)loginButtonClick {
    
    [self.userNameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    if (self.userNameTextField.text == nil||[self.userNameTextField.text isEqualToString:@""]) {
        [self showToastMessage:@"主人，请输入您的帐号"];
        return;
    }
    
    if (self.passwordTextField.text == nil||[self.passwordTextField.text isEqualToString:@""]) {
        [self showToastMessage:@"主人，请输入你的密码"];
        return;
    }
    
    [self showHUDWithMessage:@"登录中..."];
    
    [[WSDataCenter shareDataCenter] LoginWithName:self.userNameTextField.text andPassword:self.passwordTextField.text Completion:nil];
}

#pragma mark - textFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    long targetLength = textField.text.length + string.length;
    
    if (textField == self.userNameTextField) {
        if (targetLength > 50) {
            [self showToastMessage:@"主人，名字太长了"];
            return NO;
        }
    } else if (textField == self.passwordTextField) {
        if (targetLength > 16) {
            [self showToastMessage:@"主人，密码最长16个字符"];
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.userNameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if(textField == self.passwordTextField ){
        [self.passwordTextField resignFirstResponder];
        [self loginButtonClick];
    }
    return YES;
}

#pragma mark - 登录状态发生变化
- (void)loginStateUpdated:(NSNotification*)notice {
    
    [self hideHUD];
    
    if ([WSDataCenter shareDataCenter].currentUser.loginType != UserLoginTypeLogout) {
        [self showToastMessage:@"登录成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        NSString * desc = [notice.userInfo objectForKey:@"desc"];
        if ([desc isKindOfClass:[NSString class]]) {
            [self showToastMessage:desc];
        }else {
            [self showToastMessage:@"登录失败"];
        }
    }
}

#pragma mark - 键盘处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([self.userNameTextField isFirstResponder]) {
        [self.userNameTextField resignFirstResponder];
    }
    if ([self.passwordTextField isFirstResponder]) {
        [self.passwordTextField resignFirstResponder];
    }
}

#pragma mark - 通知处理
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateUpdated:) name:LoginStateRefreshed object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LoginStateRefreshed object:nil];
}

@end
