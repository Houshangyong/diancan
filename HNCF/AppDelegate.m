//
//  AppDelegate.m
//  HNCF
//
//  Created by Apple on 15/11/17.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "AppDelegate.h"
#import "HNCFCommmon.h"
#define appKey @"88dc39adeb70"
#define appSecret @"e5930bdc993c3e291f7b00e4d15a5d54"
//APP端签名相关头文件
#import "payRequsestHandler.h"
#import <QuartzCore/QuartzCore.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
    return self;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        
        self.window.rootViewController = self.guideViewController;
        
    }else{
    self.window.rootViewController = self.tabBarController;
    }
    // customize navigation bar
//    [UINavigationBar appearance].barTintColor = DEFAULT_COLOR;
//    [UITabBar appearance].barTintColor = DEFAULT_COLOR;
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:DEFAULT_COLOR} forState:UIControlStateSelected];
    [UINavigationBar appearance].translucent = NO;
    [UINavigationBar appearance].titleTextAttributes = @{ NSForegroundColorAttributeName : [UIColor blackColor], NSFontAttributeName : [UIFont systemFontOfSize:20] };
    //向微信注册
    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    [self.window makeKeyAndVisible];

    return YES;
}
-(void) changeScene:(NSInteger )scene
{
    _scene = (enum WXScene)scene;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([WXApi handleOpenURL:url delegate:self]) {
        return [WXApi handleOpenURL:url delegate:self];
    }else{
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService]
             processOrderWithPaymentResult:url
             standbyCallback:^(NSDictionary *resultDic) {
                 NSLog(@"result = %@",resultDic);
             }];
        }
        return YES;
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}
-(void)onResp:(BaseResp*)resp{
    
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    if ([resp isKindOfClass:[PayResp class]]){
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"success"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
            }
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                NSNotification *notification = [NSNotification notificationWithName:@"ORDER_PAY_NOTIFICATION" object:@"fail"];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                break;
        }
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //        [alert show];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (MTTabBarController *)tabBarController {
    if (!_tabBarController) {
        _tabBarController = [[MTTabBarController alloc] init];
        
        NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:4];
        
        NSArray *listForControllerName = @[@"HNCFHomeViewController",
                                           @"HNCFOrderViewController",
                                           @"HNCFShopViewController",
                                           @"HNCFMineViewController"];
        for (NSString *item in listForControllerName) {
            id vc = [[NSClassFromString(item) alloc] init];
            
            [viewControllers addObject:[[UINavigationController alloc] initWithRootViewController:vc]];
        }
        
        [_tabBarController setViewControllers:viewControllers];
        
        [self.tabBarController switchToViewControllerAtIndex:0];
    }
    
    return _tabBarController;

    }

- (UITabBarController*)rootViewController
{
    UITabBarController* tabBarController = [[UITabBarController alloc] init];
    
    HNCFHomeViewController* homeViewController = [[HNCFHomeViewController alloc] init];
    HNCFOrderViewController* orderViewController = [[HNCFOrderViewController alloc] init];
    HNCFShopViewController* shopViewController = [[HNCFShopViewController alloc] init];
    HNCFMineViewController* meViewController = [[HNCFMineViewController alloc] init];
    NSArray* subControllers = @[ homeViewController, orderViewController, shopViewController, meViewController ];
    NSMutableArray* tabSubControllers = [[NSMutableArray alloc] init];
    
    NSArray* titles = @[ @"闪购", @"订单", @"购物车", @"我的" ];
    NSArray* tabImageNames = @[ @"All", @"T2", @"bianlidian", @"T3" ];
    NSArray* tabSelectedImageNames = @[ @"All1", @"T2S", @"bianlidian1", @"T3S" ];
    [subControllers enumerateObjectsUsingBlock:^(UIViewController* controller, NSUInteger idx, BOOL* stop) {
        controller.tabBarItem.title = titles[idx];

        [controller.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:tabSelectedImageNames[idx]] withFinishedUnselectedImage:[UIImage imageNamed:tabImageNames[idx]]];

        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
            [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:DEFAULT_COLOR} forState:UIControlStateSelected];

        UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
        [tabSubControllers addObject:navigationController];
    }];
    tabBarController.viewControllers = tabSubControllers;
    tabBarController.selectedIndex = 0;
    return tabBarController;
}

- (MTGuideViewController *)guideViewController {
    if (!_guideViewController) {
        _guideViewController = [[MTGuideViewController alloc]init];
        
    }
    
    return _guideViewController;
}




@end
