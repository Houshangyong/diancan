//
//  MJProgressHUD.m
//  mj
//
//  Created by Apple on 15/6/11.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "MJProgressHUD.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
@interface MJProgressHUD ()

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) MBProgressHUD *hud1;

+ (instancetype)sharedInstance;

@end

@implementation MJProgressHUD

+ (instancetype)sharedInstance {
    static MJProgressHUD *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[MJProgressHUD alloc] init];
    });
    
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.hud = [[MBProgressHUD alloc] initWithWindow:appDelegate.window];
        self.hud.mode = MBProgressHUDModeText;
        self.hud.animationType = MBProgressHUDAnimationFade;
        
        self.hud.dimBackground = YES;
        [appDelegate.window addSubview:self.hud];
        [appDelegate.window addSubview:self.hud];
        self.hud1 = [[MBProgressHUD alloc] initWithWindow:appDelegate.window];
        self.hud1.mode = MBProgressHUDModeIndeterminate;
        self.hud1.animationType = MBProgressHUDAnimationFade;
        
        self.hud1.dimBackground = YES;
        
        [appDelegate.window addSubview:self.hud1];
    }
    return self;
}

+ (void)showHUDWithText:(NSString *)text {
    [[MJProgressHUD sharedInstance].hud hide:NO];
    [MJProgressHUD sharedInstance].hud.labelText = text;
    [[MJProgressHUD sharedInstance].hud show:YES];
}

+ (void)showHUDWithText:(NSString *)text duration:(NSTimeInterval)duration {
    if ([text isEqualToString:@""]) {
        [MJProgressHUD hide];
    }else{
        [MJProgressHUD showHUDWithText:text];
        [MJProgressHUD hideHUDWithDelay:duration];

    }
  }

+ (void)hide {
    [[MJProgressHUD sharedInstance].hud hide:YES];
}

+ (void)hideHUDWithDelay:(NSTimeInterval)delay {
    [[MJProgressHUD sharedInstance].hud hide:YES afterDelay:delay];
}
+ (void)showHUDWithText1:(NSString *)text {
    [[MJProgressHUD sharedInstance].hud1 hide:NO];
    [MJProgressHUD sharedInstance].hud1.labelText = text;
    [[MJProgressHUD sharedInstance].hud1 show:YES];
}

+ (void)showHUDWithText1:(NSString *)text duration:(NSTimeInterval)duration {
    [MJProgressHUD showHUDWithText:text];
    [MJProgressHUD hideHUDWithDelay:duration];
}

+ (void)hide1 {
    [[MJProgressHUD sharedInstance].hud1 hide:YES];
}

+ (void)hideHUDWithDelay1:(NSTimeInterval)delay {
    [[MJProgressHUD sharedInstance].hud1 hide:YES afterDelay:delay];
}

@end
