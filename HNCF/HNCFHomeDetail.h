//
//  HNCFHomeDetail.h
//  HNCF
//
//  Created by Apple on 15/12/29.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNCFHomeDetail;
@protocol HNCFHomeDetailDelegate <NSObject>

- (void)HNCFHomeDetailIndex:(HNCFHomeDetail *)headView index:(id)model;

@end
@interface HNCFHomeDetail : UIView
- (void)HNCFHomeDetailVIew1:(id)model comentCount:(NSArray *)array;
@property (nonatomic, strong)id<HNCFHomeDetailDelegate>delegate;

@end
