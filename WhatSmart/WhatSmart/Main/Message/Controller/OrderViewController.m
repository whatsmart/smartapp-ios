//
//  OrderViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderModel.h"
#import "OrderTableViewCell.h"

@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray* dataArray;


@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) UIView * inputBottomView;
@property (strong, nonatomic) UITextField * msgTextField;
@end

static NSString *const msgreuseIdentifier = @"msgUITableViewCellIdentifier";


@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self loadData];
}

-(void)setupView
{
    //命令列表
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-90)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = self.view.backgroundColor;
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    //底部输入部分
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-90, kScreenW, 40)];
    bottomView.backgroundColor = UIColorFromHex(0xf0f0f0);
    self.inputBottomView = bottomView;
    //语音
    UIButton * voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 5, 45, 30)];
    voiceButton.backgroundColor = WSColor;
    [voiceButton setTitle:@"语音" forState:UIControlStateNormal];
    voiceButton.layer.cornerRadius = 5;
    __weak __typeof(&*self)weakSelf = self;
    [voiceButton addActionHandler:^(NSInteger tag) {
        [weakSelf voiceBtnAction];
    }];
    [self.inputBottomView addSubview:voiceButton];
    //命令输入框
    UITextField * OrderTextField = [[UITextField alloc] initWithFrame:CGRectMake(voiceButton.right+5, 5, kScreenW- 35 -35 , 30)];
    OrderTextField.layer.cornerRadius = 5;
    OrderTextField.layer.borderColor = [UIColor grayColor].CGColor;
    OrderTextField.layer.borderWidth = 1;
    OrderTextField.placeholder = @"主人，请输入命令！";
    OrderTextField.returnKeyType = UIReturnKeyDone;
    OrderTextField.delegate = self;
    self.msgTextField = OrderTextField;
    [self.inputBottomView addSubview:self.msgTextField];
    
    [self.view addSubview:self.inputBottomView];
}

-(void)loadData
{
    self.dataArray = [NSMutableArray new];
}

-(void) voiceBtnAction
{
    [self showToastMessage:@"程序员正在开发中..."];
}
-(void)sendOrder
{
    //检验命令
    if (self.msgTextField.text.length <= 0) {
        return;
    }
    
    //发送命令
    OrderModel * model = [[OrderModel alloc] init];
    model.timestamp = [[NSDate new] timeIntervalSince1970];
    model.content = [NSString stringWithString:self.msgTextField.text];
    
    [self.dataArray addObject:model];
    
    self.msgTextField.text = nil;
    
    [self.tableView reloadData];
}

#pragma mark - Notification
-(void)keyBoardWillShow:(NSNotification*) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    DLog(@"keyBoard:%f", keyboardSize.height); //216
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.tableView setFrame:CGRectMake(0, self.tableView.top - keyboardSize.height,_tableView.width, _tableView.height)];
    [self.inputBottomView setFrame:CGRectMake(0,_inputBottomView.top - keyboardSize.height, kScreenW, 40)];

    [UIView commitAnimations];
    
    
}
-(void)keyBoardWillHide:(NSNotification*) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    DLog(@"keyBoard:%f", keyboardSize.height); //216
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [self.tableView setFrame:CGRectMake(0, 0,_tableView.width, _tableView.height)];
    [self.inputBottomView setFrame:CGRectMake(0, kScreenH-90, kScreenW, 40)];

    [UIView commitAnimations];
    

}

-(void) p_installNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:)  name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) p_removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil ];
}
#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    [self sendOrder];
    return YES;
}
#pragma mark - getter and setter
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:msgreuseIdentifier ];

    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:msgreuseIdentifier];
    }
    [cell setDataWithModel:[self.dataArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - life cycle
-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self p_installNotification];
    
}

-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self p_removeNotification];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
