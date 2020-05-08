//
//  MTTabBarView.m
//  MTGJ
//
//  Created by zhouxz on 14/11/17.
//  Copyright (c) 2014年 MallTang. All rights reserved.
//

#import "MTTabBarView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+FrameEx.h"

#define MT_TAB_BAR_BUTTON_TAG_BASE 100

@interface MTTabBarView ()

@end

@implementation MTTabBarView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *xian = [[UIImageView alloc]initWithFrame:CGRectMake(0, 1, self.width,0.5)];
        xian.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:xian];
//        @[ @"All", @"T2", @"bianlidian", @"T3"
        
     
        CGRect rect0 = CGRectMake(20, 10, 64, 44);
        [self setButtonWithTitle:@"菜单"
                     normalImage:[UIImage imageNamed:@"All"]
                   selectedImage:[UIImage imageNamed:@"All1"]
                           frame:rect0
                           index:0];
     
        CGRect rect1 = CGRectMake(([UIScreen mainScreen].bounds.size.width-256-40)/3+64+20, 10, 64, 44);
        [self setButtonWithTitle:@"订单"
                     normalImage:[UIImage imageNamed:@"T2"]
                   selectedImage:[UIImage imageNamed:@"T2S"]
                           frame:rect1
                           index:1];
        CGRect rect2 = CGRectMake(([UIScreen mainScreen].bounds.size.width-256-40)/3*2+64*2+20, 10, 64, 44);
        [self setButtonWithTitle:@"购物车"
                     normalImage:[UIImage imageNamed:@"bianlidian"]
                   selectedImage:[UIImage imageNamed:@"bianlidian1"]
                           frame:rect2
                           index:2];
        CGRect rect3 = CGRectMake(([UIScreen mainScreen].bounds.size.width-256-40)/3*3+64*3+20, 10, 64, 44);

        [self setButtonWithTitle:@"我的"
                     normalImage:[UIImage imageNamed:@"T3"]
                   selectedImage:[UIImage imageNamed:@"T3S"]
                           frame:rect3
                           index:3];

    }
    return self;
}

- (void)setButtonWithTitle:(NSString *)title normalImage:(UIImage *)normalImage selectedImage:(UIImage *)selectedImage frame:(CGRect)frame index:(NSUInteger)index {
    
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = frame;
    item.tag = MT_TAB_BAR_BUTTON_TAG_BASE+index;
    [item addTarget:self action:@selector(onHitButton:) forControlEvents:UIControlEventTouchDown];
    [item setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [item setTitle:title forState:UIControlStateNormal];
    [item setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    item.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    [item setImage:normalImage forState:UIControlStateNormal];
    [item setImage:selectedImage forState:UIControlStateSelected];
    if (title) {
        [item setImageEdgeInsets:UIEdgeInsetsMake(-16, 12, 10, -8)];
        [item setTitleEdgeInsets:UIEdgeInsetsMake(6, -19, -6, 8)];
    }
    [self addSubview:item];
}

- (void)onHitButton:(UIButton *)button {
    [self setSelectedStateForButtonAtIndex:button.tag-MT_TAB_BAR_BUTTON_TAG_BASE];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(mtTabbar:didSelectItemAtIndex:)]) {
        [self.delegate mtTabbar:self didSelectItemAtIndex:button.tag-MT_TAB_BAR_BUTTON_TAG_BASE];
    }
}

- (void)setSelectedStateForButtonAtIndex:(NSInteger)index {
    UIButton *button = (UIButton *)[self viewWithTag:MT_TAB_BAR_BUTTON_TAG_BASE+index];
    
    if (button.isSelected) {
        return;
    }
    
    for (UIView *view in [self subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            [(UIButton *)view setSelected:NO];
        }
    }
    
    [button setSelected:YES];
}

@end
