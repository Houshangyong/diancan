//
//  HNCFPayView.h
//  HNCF
//
//  Created by houshangyong on 15/11/23.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNCFPayView;
@protocol HNCFPayViewDelegate <NSObject>

- (void)withUserIndex:(HNCFPayView *)headView num:(NSString *)numString price:(NSString *)priceString model:(id)modelll;

@end
@interface HNCFPayView : UIView
@property (nonatomic, weak) id<HNCFPayViewDelegate> delegate;
- (void)resetNumAndPrice:(id)model;

@end
