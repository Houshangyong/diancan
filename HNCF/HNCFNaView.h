//
//  HNCFNaView.h
//  HNCF
//
//  Created by Apple on 15/11/18.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HNCFNaView;
@protocol HNCFNaViewDelegate <NSObject>
- (void)didSelectLeft;
- (void)didSelectRight;
//- (void)HNCFNaView:(HNCFNaView *)bannerView didSelectItem:(NSDictionary *)itemData Index:(NSInteger)index;
@end
@interface HNCFNaView : UIView
@property (nonatomic, weak) id<HNCFNaViewDelegate> delegate;
- (void)setHomeBannerData:(NSString *)titleString locationImage:(BOOL)hide rightButton:(BOOL)hide1 leftButton:(BOOL)hide2 rightImage:(UIImage *)image;

@end
