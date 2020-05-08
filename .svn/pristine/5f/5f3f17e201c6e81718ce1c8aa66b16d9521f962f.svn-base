//
//  MTTabBarView.h
//  MTGJ
//
//  Created by zhouxz on 14/11/17.
//  Copyright (c) 2014年 MallTang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTTabBarView;
@protocol MTTabBarViewDelegate <NSObject>

- (void)mtTabbar:(MTTabBarView *)tabbar didSelectItemAtIndex:(NSUInteger)index;

@end

@interface MTTabBarView : UIView

@property (nonatomic, weak) id<MTTabBarViewDelegate> delegate;

- (void)setSelectedStateForButtonAtIndex:(NSInteger)index;

@end
