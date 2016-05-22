//
//  WSMainNavigationController.m
//  WhatSmart
//
//  Created by 董力云 on 16/5/22.
//  Copyright © 2016年 董力云. All rights reserved.
//

#import "WSMainNavigationController.h"

#define KEY_WINDOW  [[UIApplication sharedApplication]keyWindow]

#import <QuartzCore/QuartzCore.h>
#import "WSToolsObject.h"

@interface WSMainNavigationController (){
    
    CGPoint startTouch;
    
    UIImageView *lastScreenShotView;
    UIView *blackMask;
    
    //    NSString *_updateURL;
    BOOL _hasShowAlert;
}

@property (nonatomic,retain) UIView *backgroundView;
@property (nonatomic,retain) NSMutableArray *screenShotsList;

@property (nonatomic,assign) BOOL isMoving;

@property (strong, nonatomic) NSString *updateURL;

@end

@implementation WSMainNavigationController {
    __strong UILabel *_debugLabel;
    __strong UILabel *_debugInfoLabel;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.screenShotsList = [[NSMutableArray alloc] initWithCapacity:2];
        self.canDragBack = YES;
        
        _hasShowAlert = NO;
        
    }
    return self;
}

- (void)dealloc{
    
    self.screenShotsList = nil;
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //    [self.navigationBar setHidden:YES];
    
    [self setNavigationBarHidden:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    _hasShowAlert = NO;
    
    if (buttonIndex==0) {
        exit(0);
    }else{
        NSURL *tmpURL = [NSURL URLWithString:self.updateURL];
        [[UIApplication sharedApplication] openURL:tmpURL];
    }
}

- (void)p_forbidAction:(NSNotification*)noti{
    
    if (_hasShowAlert) {
        return;
    }
    
    _hasShowAlert = YES;
    
    self.updateURL = [noti.userInfo valueForKey:@"AbandonURL"];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:[noti.userInfo valueForKey:@"msg"] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"更新", nil];
    [alertView show];
}

- (void)p_openDebug:(NSNotification*)noti{
    
    BOOL isOpenDebug = [noti.object boolValue];
    
    [_debugLabel setHidden:!isOpenDebug];
    [_debugInfoLabel setHidden:!isOpenDebug];
    [[NSUserDefaults standardUserDefaults] setBool:isOpenDebug forKey:@"DebugModel"];
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.screenShotsList = [NSMutableArray array];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_forbidAction:) name:FORBID_VERSION object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(p_openDebug:) name:OPEN_DEBUG object:nil];
//    
//    _debugLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
//    [_debugLabel setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:.6]];
//    [_debugLabel setText:@"调试模式"];
//    [_debugLabel setFont:[UIFont systemFontOfSize:20]];
//    [_debugLabel setTextColor:[UIColor whiteColor]];
//    [_debugLabel setTextAlignment:NSTextAlignmentLeft];
//    [_debugLabel setHidden:YES];
//    [self.view addSubview:_debugLabel];
//    
//    _debugInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 44, SCREEN_WIDTH, 20)];
//    [_debugInfoLabel setBackgroundColor:[UIColor clearColor]/*[UIColor colorWithRed:0 green:0 blue:0 alpha:.6]*/];
//    [_debugInfoLabel setText:[NSString stringWithFormat:@"版本号:%@  渠道号:%@  系统版本:iOS%.1f",APP_VERSION,RELEASE_CHANNEL,SYSTEM_VERSION]];
//    [_debugInfoLabel setFont:[UIFont systemFontOfSize:13]];
//    [_debugInfoLabel setTextColor:[UIColor whiteColor]];
//    [_debugInfoLabel setTextAlignment:NSTextAlignmentLeft];
//    [_debugInfoLabel setHidden:YES];
//    [self.view addSubview:_debugInfoLabel];
//    
    
    [self p_setNavigationControllerStyle];
    
    //    [self.navigationController.navigationBar.layer setMasksToBounds:YES];
    
    // draw a shadow for navigation view to differ the layers obviously.
    // using this way to draw shadow will lead to the low performace
    // the best alternative way is making a shadow image.
    //
    //self.view.layer.shadowColor = [[UIColor blackColor]CGColor];
    //self.view.layer.shadowOffset = CGSizeMake(5, 5);
    //self.view.layer.shadowRadius = 5;
    //self.view.layer.shadowOpacity = 1;
    
    UIImageView *shadowImageView = [[UIImageView alloc]initWithImage:[WSToolsObject loadImageWithName:@"leftside_shadow_bg"]];
    shadowImageView.frame = CGRectMake(-10, 0, 10, self.view.frame.size.height);
    [self.view addSubview:shadowImageView];
    
    UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                           
                                                                                 action:@selector(paningGestureReceive:)];
    [recognizer delaysTouchesBegan];
    recognizer.delegate = self;
    [recognizer requireGestureRecognizerToFail:[[UISwipeGestureRecognizer alloc] init]];
    [self.view addGestureRecognizer:recognizer];
}

- (BOOL)gestureRecognizer:(UIPanGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UISwipeGestureRecognizer*) otherGesture{
    if ([otherGesture isKindOfClass:[UISwipeGestureRecognizer class]]) {
        return YES;
    }
    return NO;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count == 1) {
        return NO;
    }else{
        return YES;
    }
}

- (void)p_setNavigationControllerStyle{
    
    NSDictionary *parametersDic = @{UITextAttributeTextColor:[UIColor whiteColor],
                                    UITextAttributeFont:[UIFont boldSystemFontOfSize:21]};
    [self.navigationBar setTitleTextAttributes:parametersDic];
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        [self.navigationBar setTintColor:WSColor];
    }else{
        [self.navigationBar setBarTintColor:WSColor];
        [self.navigationBar setTintColor:[UIColor whiteColor]];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// override the push method
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [self.screenShotsList addObject:[self capture]];
    
    [super pushViewController:viewController animated:animated];
}

// override the pop method
- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    [self.screenShotsList removeLastObject];
    
    return [super popViewControllerAnimated:animated];
}

#pragma mark - Utility Methods -

// get the current view screen shot
- (UIImage *)capture{
    
    /*这段截图代码存在内存泄漏
     UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, self.view.opaque, 0.0);
     
     [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
     
     UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
     
     UIGraphicsEndImageContext();
     
     return img;
     */
    
    size_t width = self.view.bounds.size.width;
    size_t height = self.view.bounds.size.height;
    
    unsigned char *imageBuffer = (unsigned char *)malloc(width*height*4);
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef imageContext =
    CGBitmapContextCreate(imageBuffer, width, height, 8, width*4, colourSpace,
                          kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
    
    CGColorSpaceRelease(colourSpace);
    
    [self.view.layer renderInContext:imageContext];
    
    CGImageRef outputImage = CGBitmapContextCreateImage(imageContext);
    
    UIImage *img = [UIImage imageWithCGImage:outputImage scale:1.0 orientation:UIImageOrientationDownMirrored];
    
    CGImageRelease(outputImage);
    CGContextRelease(imageContext);
    free(imageBuffer);
    
    return img;
}

// set lastScreenShotView 's position and alpha when paning
- (void)moveViewWithX:(float)x
{
    
    //    NSLog(@"Move to:%f",x);
    x = x>320?320:x;
    x = x<0?0:x;
    
    CGRect frame = self.view.frame;
    frame.origin.x = x;
    self.view.frame = frame;
    
    float scale = (x/6400)+0.95;
    float alpha = 0.4 - (x/800);
    
    lastScreenShotView.transform = CGAffineTransformMakeScale(scale, scale);
    blackMask.alpha = alpha;
    
}

#pragma mark - Gesture Recognizer -

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer{
    
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait) {
        return;
    }
    DLog(@"%s",__func__);
    // If the viewControllers has only one vc or disable the interaction, then return.
    if (self.viewControllers.count <= 1 || !self.canDragBack) return;
    
    // we get the touch position by the window's coordinate
    CGPoint touchPoint = [recoginzer locationInView:KEY_WINDOW];
    
    // begin paning, show the backgroundView(last screenshot),if not exist, create it.
    if (recoginzer.state == UIGestureRecognizerStateBegan) {
        
        _isMoving = YES;
        startTouch = touchPoint;
        
        if (!self.backgroundView)
        {
            CGRect frame = self.view.frame;
            
            self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            [self.view.superview insertSubview:self.backgroundView belowSubview:self.view];
            
            blackMask = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width , frame.size.height)];
            blackMask.backgroundColor = [UIColor blackColor];
            [self.backgroundView addSubview:blackMask];
        }
        
        self.backgroundView.hidden = NO;
        
        if (lastScreenShotView) [lastScreenShotView removeFromSuperview];
        
        UIImage *lastScreenShot = [self.screenShotsList lastObject];
        lastScreenShotView = [[UIImageView alloc]initWithImage:lastScreenShot];
        [self.backgroundView insertSubview:lastScreenShotView belowSubview:blackMask];
        
        //End paning, always check that if it should move right or move left automatically
    }else if (recoginzer.state == UIGestureRecognizerStateEnded){
        
        if (touchPoint.x - startTouch.x > 50)
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:320];
            } completion:^(BOOL finished) {
                
                [self popViewControllerAnimated:NO];
                CGRect frame = self.view.frame;
                frame.origin.x = 0;
                self.view.frame = frame;
                
                _isMoving = NO;
            }];
        }
        else
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self moveViewWithX:0];
            } completion:^(BOOL finished) {
                _isMoving = NO;
                self.backgroundView.hidden = YES;
            }];
            
        }
        return;
        
        // cancal panning, alway move to left side automatically
    }else if (recoginzer.state == UIGestureRecognizerStateCancelled){
        
        [UIView animateWithDuration:0.3 animations:^{
            [self moveViewWithX:0];
        } completion:^(BOOL finished) {
            _isMoving = NO;
            self.backgroundView.hidden = YES;
        }];
        
        return;
    }
    
    // it keeps move with touch
    if (_isMoving) {
        [self moveViewWithX:touchPoint.x - startTouch.x];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (BOOL)shouldAutorotate{
    return [self.viewControllers.lastObject shouldAutorotate];
}

- (NSUInteger)supportedInterfaceOrientations{
    return [self.viewControllers.lastObject supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return [self.viewControllers.lastObject preferredInterfaceOrientationForPresentation];
}
@end

