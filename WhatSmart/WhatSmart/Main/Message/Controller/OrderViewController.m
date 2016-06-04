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
static NSInteger indexMsg = 0;

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH-100)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = UIColorFromHex(0xf0f0f0);
    self.tableView = tableView;
    [self.view addSubview:self.tableView];
    //底部输入部分
    UIView * bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenH-100, kScreenW, 50)];
    bottomView.backgroundColor = [UIColor whiteColor] ;
    self.inputBottomView = bottomView;
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.width, 1)];
    lineView.backgroundColor =  RGBColor(236, 236, 236);
    [self.inputBottomView addSubview:lineView];
    
    //语音
    UIView * voiceBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    voiceBackView.backgroundColor = [UIColor clearColor];
    UIButton * voiceButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    voiceButton.backgroundColor = [UIColor clearColor];
    [voiceButton setBackgroundImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
    voiceButton.layer.cornerRadius = 5;
    [voiceBackView addSubview:voiceButton];
    __weak __typeof(&*self)weakSelf = self;
    [voiceButton addActionHandler:^(NSInteger tag) {
        [weakSelf voiceBtnAction];
    }];
    [self.inputBottomView addSubview:voiceBackView];
    //命令输入框
    UITextField * OrderTextField = [[UITextField alloc] initWithFrame:CGRectMake(voiceButton.right+5, 5, kScreenW-voiceButton.width-10 , 40)];
    OrderTextField.layer.cornerRadius = 5;
    OrderTextField.layer.borderColor =  RGBColor(236, 236, 236).CGColor;
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
    model.isSelf =  (indexMsg%2 == 0) ? YES:NO;
    indexMsg++;
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
    [self.tableView setFrame:CGRectMake(0, self.tableView.top - 220,_tableView.width, _tableView.height)];
    [self.inputBottomView setFrame:CGRectMake(0,_inputBottomView.top - 220, kScreenW, _inputBottomView.height)];

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
    [self.inputBottomView setFrame:CGRectMake(0, _inputBottomView.top+220, kScreenW, _inputBottomView.height)];

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
    OrderModel * model = [_dataArray objectAtIndex:indexPath.row];
    CGSize msgSize = [model.content sizeWithFont:[UIFont systemFontOfSize:15]];
    NSInteger line = msgSize.width / (kScreenW-20-IMAHE_WIDTH*2-15) + 1;
    NSLog(@"msgSize:[%f %f],line:%ld",msgSize.width,msgSize.height,(long)line);
    return line * msgSize.height + 15;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:msgreuseIdentifier ];

    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:msgreuseIdentifier];
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
