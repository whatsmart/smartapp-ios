//
//  WSFeedBackViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//
//  意见反馈 界面

#import "WSFeedBackViewController.h"

@interface WSFeedBackViewController () <UITextViewDelegate>

@property (weak, nonatomic) UIView *editView;
@property (weak, nonatomic) UITextView *editTextView;
@property (weak, nonatomic) UITextView *showTextView;

@end

@implementation WSFeedBackViewController

static NSString *const pageName = @"意见反馈";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpView];
}

#pragma mark - 初始化界面
- (void)setUpView {
    self.view.backgroundColor = [UIColor whiteColor];
    [self creatTopBar];
    [self creatNavBackButton];
    self.title = @"意见反馈";
    
    UIView *editView = [self creatEditView];
    [self.view addSubview:editView];
    self.editView = editView;
    [editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    UITextView *showTextView = [UITextView new];
    showTextView.layer.cornerRadius = 3;
    showTextView.backgroundColor = RGBAColor(0, 0, 0, 0.2);
    showTextView.textColor = [UIColor whiteColor];
    showTextView.textAlignment = NSTextAlignmentCenter;
    showTextView.font = [UIFont systemFontOfSize:14];
    showTextView.userInteractionEnabled = NO;
    showTextView.text = @"系统提示：禁止反动、色情、暴力等不良信息，经发现一律封号处理";
    [self.view addSubview:showTextView];
    self.showTextView = showTextView;
    [showTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(75);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.mas_equalTo(60);
    }];
}

#pragma mark - 创建编辑界面
- (UIView *)creatEditView {
    
    UIView *bgView = [UIView new];
    
    UIView *topLineView = [UIView new];
    topLineView.backgroundColor = RGBColor(236, 236, 236);
    [bgView addSubview:topLineView];
    [topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIButton *sendButton = [UIButton new];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [bgView addSubview:sendButton];
    [sendButton addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    [sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(6);
        make.right.bottom.equalTo(bgView).offset(-5);
        make.width.mas_equalTo(60);
    }];
    
    UITextView *editTextView = [UITextView new];
    editTextView.font = [UIFont systemFontOfSize:14];
    editTextView.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    editTextView.layer.borderWidth = 1;
    editTextView.layer.cornerRadius = 3;
    editTextView.returnKeyType = UIReturnKeySend;
    editTextView.delegate = self;
    [bgView addSubview:editTextView];
    self.editTextView = editTextView;
    [editTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView).offset(6);
        make.left.equalTo(bgView).offset(10);
        make.bottom.equalTo(bgView).offset(-5);
        make.right.equalTo(sendButton.mas_left).offset(-5);
    }];
    
    return bgView;
}

#pragma mark - textViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 140) {
        [self showToastMessage:@"主人，文字太长了"];
        textView.text = [textView.text substringToIndex:140];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {//发送按钮点击
        [self sendClick];
        return NO;
    }else if ([text isEqualToString:@" "]) {//空格处理
        return NO;
    }else {
        return YES;
    }
}

#pragma mark - 发送按钮点击
- (void)sendClick {
    
    
    if (self.editTextView.text.length == 0) {
        [self showToastMessage:@"主人，还没有输入反馈内容哦"];
        return;
    }
    
    [self.editTextView resignFirstResponder];
    
    self.showTextView.text = self.editTextView.text;
    self.showTextView.textAlignment = NSTextAlignmentLeft;
    self.showTextView.textColor = RGBColor(0x8b, 0x8b, 0x8b);
    self.showTextView.backgroundColor = [UIColor whiteColor];
    self.showTextView.layer.borderColor = RGBColor(0xe8, 0xe8, 0xe8).CGColor;
    self.showTextView.layer.borderWidth = 1;
    self.editTextView.text = @"";
    
//    NSString * jsonString =[NSString stringWithFormat: @"{\"message\":\"%@\"}",self.showTextView.text];
//    NSString *urlStr = [UrlFeedback(jsonString) stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURLRequest * request = [NSURLRequest   requestWithURL:[NSURL URLWithString:urlStr]];
//    __weak __typeof(&*self)weakeSelf = self;
//    
//    AFHTTPRequestOperation* operation = [[AFNetworkingAPIClient sharedClient]HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([operation.responseString isEqualToString:@"Success"]) {
//            [weakeSelf showToastMessage:@"反馈成功"];
//        }else{
//            [weakeSelf showToastMessage:@"反馈失败"];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        DLog(@"responseString %@  error %@",operation.responseString,error);
//        [weakeSelf showToastMessage:@"网络连接失败"];
//    }];
//    
//    operation.responseSerializer = [[AFHTTPResponseSerializer alloc]init];
//    [[[AFNetworkingAPIClient sharedClient]operationQueue]addOperation:operation];
}

#pragma mark - 键盘处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.editTextView resignFirstResponder];
}

-(void)keyboardFrameChanged:(NSNotification *)notice{
    
    CGRect endFrame = [[notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval duration = [[notice.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [self.editView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-1 * (self.view.frame.size.height - endFrame.origin.y));
    }];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - 统计相关
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - 通知相关
- (void)p_registNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)p_removeNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self p_registNotification];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self p_removeNotification];
}

@end
