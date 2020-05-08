//
//  MJAlertView.h
//  mj
//
//  Created by Apple on 15/10/23.
//  Copyright © 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^block)(NSString*);

@interface MJAlertView : UIView
- (id)initWithTitle:(NSString *)title
        contentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
             status:(NSString *)status;

- (void)show;
@property (nonatomic, copy) block leftBlock;
@property (nonatomic, copy) block rightBlock;
@property (nonatomic, copy) block dismissBlock;


@end
@interface UIImage (colorful)

+ (UIImage *)imageWithColor:(UIColor *)color;

@end