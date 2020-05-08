//
//  MTTabBarController.m
//  MTGJ
//
//  Created by zhouxz on 14/11/17.
//  Copyright (c) 2014年 MallTang. All rights reserved.
//

#import "MTTabBarController.h"
#import "UIView+FrameEx.h"
#import "HNCFCommmon.h"
#define MT_CONST_TABBAR_HEIGHT          49


@interface MTTabBarController () <MTTabBarViewDelegate>

@end

@implementation MTTabBarController

- (MTTabBarView *)mtTabBarView {
    if (!_mtTabBarView) {
        _mtTabBarView = [[MTTabBarView alloc] initWithFrame:CGRectMake(0, self.view.height-MT_CONST_TABBAR_HEIGHT, self.view.width, MT_CONST_TABBAR_HEIGHT)];
        _mtTabBarView.delegate = self;
    }
    return _mtTabBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.y = [UIScreen mainScreen].bounds.size.height;
    [self.view addSubview:self.mtTabBarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)switchToViewControllerAtIndex:(NSInteger)index {
    self.selectedIndex = index;
    [self.mtTabBarView setSelectedStateForButtonAtIndex:index];
}

- (void)setTabBarHidden:(BOOL)hidden {
    
    NSInteger screenHeight = [[UIScreen mainScreen] bounds].size.height;
    NSInteger customHeight = hidden ? screenHeight : (screenHeight - MT_CONST_TABBAR_HEIGHT);
    
    CGFloat diff = 30; // 中间的按钮有点大了，需要多隐藏一些
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UITabBar class]]) {
            view.y = screenHeight;
        } else if ([view isKindOfClass:[MTTabBarView class]]) {
            view.y = hidden ? customHeight + diff : customHeight;
        } else {
            view.height = customHeight;
//            NSLog(@"");
        }
    }
    [UIView commitAnimations];
}

#pragma mark - MTTabBarViewDelegate
- (void)mtTabbar:(MTTabBarView *)tabbar didSelectItemAtIndex:(NSUInteger)index {
    self.selectedIndex = index;
}


@end
