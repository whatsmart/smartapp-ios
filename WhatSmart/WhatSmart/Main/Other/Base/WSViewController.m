//
//  WSViewController.m
//  WhatSmart
//
//  Created by 董力云 on 16/3/23.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSViewController.h"

@interface WSViewController ()

@end

@implementation WSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showToastMessage:(NSString*)message  {
    MBProgressHUD* tmpHUD = [[MBProgressHUD alloc] initWithView:self.view];
    tmpHUD.userInteractionEnabled = NO;
    [self.view addSubview:tmpHUD];
    [self.view bringSubviewToFront:tmpHUD];
    tmpHUD.mode = MBProgressHUDModeText;
    tmpHUD.delegate = self;
    tmpHUD.labelText = message;
    [tmpHUD show:YES];
    [tmpHUD hide:YES afterDelay:1.5];
    tmpHUD.removeFromSuperViewOnHide=YES;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
