//
//  MJMyLaundrycouponsView.m
//  mj
//
//  Created by Apple on 15/7/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "MJMyLaundrycouponsView.h"
#import "HNCFCommmon.h"


@interface MJMyLaundrycouponsView ()
@property (nonatomic, strong) UIButton *Button;

@property (nonatomic, strong) UIButton *oneButton;
@property (nonatomic, strong) UIButton *twoButton;
@property (nonatomic, strong) UIButton *threeButton;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIView *animationView1;
@property (nonatomic, strong) UIView *animationView2;
@property (nonatomic, strong) UIView *animationView3;

@end
@implementation MJMyLaundrycouponsView
- (UIButton *)Button
{
    if (!_Button) {
        _Button = [UIButton buttonWithType:UIButtonTypeCustom];
        _Button.frame = CGRectZero;
        [_Button setTitle:@"全部                  " forState:UIControlStateNormal];
        [_Button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _Button.font = [UIFont systemFontOfSize:15];
        _Button.tag = 0;
        _Button.titleLabel.textAlignment = NSTextAlignmentLeft;

        [_Button bk_addEventHandler:^(id sender) {
            [self didselectButton:_Button];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _Button;
}

- (UIButton *)oneButton
{
    if (!_oneButton) {
        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _oneButton.frame = CGRectZero;
        [_oneButton setTitle:@"热门推荐" forState:UIControlStateNormal];
        [_oneButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        _oneButton.font = [UIFont systemFontOfSize:15];
        _oneButton.tag = 1;

        [_oneButton bk_addEventHandler:^(id sender) {
            [self didselectButton:_oneButton];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _oneButton;
}
- (UIButton *)twoButton
{
    if (!_twoButton) {
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoButton.frame = CGRectZero;
        [_twoButton setTitle:@"热销品" forState:UIControlStateNormal];
        [_twoButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        _twoButton.font = [UIFont systemFontOfSize:15];

        _twoButton.tag = 2;

        [_twoButton bk_addEventHandler:^(id sender) {
            [self didselectButton:_twoButton];

        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _twoButton;
}
- (UIButton *)threeButton
{
    if (!_threeButton) {
        _threeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _threeButton.frame = CGRectZero;
        [_threeButton setTitle:@"特价品" forState:UIControlStateNormal];
        [_threeButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        _threeButton.tag = 3;
        _threeButton.font = [UIFont systemFontOfSize:15];

        [_threeButton bk_addEventHandler:^(id sender) {
            [self didselectButton:_threeButton];

        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _threeButton;
}
- (UIView *)animationView
{
    if (!_animationView) {
        _animationView = [[UIView alloc]initWithFrame:CGRectMake(10,self.height -10, self.Button.width, 1)];
        _animationView.backgroundColor = [UIColor redColor];
    }
    return _animationView;
}
- (UIView *)animationView1
{
    if (!_animationView1) {
        _animationView1 = [[UIView alloc]initWithFrame:CGRectMake(self.Button.maxX+10,self.height -10, self.oneButton.width, 1)];
        _animationView1.backgroundColor = [UIColor lightGrayColor];
    }
    return _animationView1;
}
- (UIView *)animationView2
{
    if (!_animationView2) {
        _animationView2 = [[UIView alloc]initWithFrame:CGRectMake(self.oneButton.maxX+10,self.height -10, self.twoButton.width, 1)];
        _animationView2.backgroundColor = [UIColor lightGrayColor];
    }
    return _animationView2;
}- (UIView *)animationView3
{
    if (!_animationView3) {
        _animationView3 = [[UIView alloc]initWithFrame:CGRectMake(self.twoButton.maxX+10,self.height -10, self.threeButton.width, 1)];
        _animationView3.backgroundColor = [UIColor lightGrayColor];
    }
    return _animationView3;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.Button];
        [self addSubview:self.oneButton];
        [self addSubview:self.twoButton];
        [self addSubview:self.threeButton];
        [self addSubview:self.animationView];
        [self addSubview:self.animationView1];
        [self addSubview:self.animationView2];
        [self addSubview:self.animationView3];

        
        
    }
    return self;
}
- (void)resetPeraonal:(id)model;
{
    [self.oneButton setTitle:[NSString stringWithFormat:@"可使用 %@",[[model objectForKey:@"datacount"] objectForKey:@"c_unused"]] forState:UIControlStateNormal];
      [self.twoButton setTitle:[NSString stringWithFormat:@"已使用 %@",[[model objectForKey:@"datacount"] objectForKey:@"c_used"]] forState:UIControlStateNormal];
      [self.threeButton setTitle:[NSString stringWithFormat:@"已失效 %@",[[model objectForKey:@"datacount"] objectForKey:@"c_expires"]] forState:UIControlStateNormal];

}
- (void)didselectButton:(UIButton *)one
{
    switch ([one tag]) {
        case 0:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.Button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            

                self.animationView.backgroundColor = [UIColor redColor];
                self.animationView1.backgroundColor = [UIColor lightGrayColor];
                self.animationView2.backgroundColor = [UIColor lightGrayColor];
                self.animationView3.backgroundColor = [UIColor lightGrayColor];

                [self.oneButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];

                [self.twoButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                [self.threeButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            }];
            
            
            
        }
            break;

        case 1:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.oneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [self.Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                self.animationView.backgroundColor = [UIColor lightGrayColor];
                self.animationView2.backgroundColor = [UIColor lightGrayColor];
                self.animationView3.backgroundColor = [UIColor lightGrayColor];
                self.animationView1.backgroundColor = [UIColor redColor];
                [self.twoButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                [self.threeButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            }];
           


        }
            break;
        case 2:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.oneButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                self.animationView2.backgroundColor = [UIColor redColor];
                [self.Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                self.animationView1.backgroundColor = [UIColor lightGrayColor];
                self.animationView.backgroundColor = [UIColor lightGrayColor];
                self.animationView3.backgroundColor = [UIColor lightGrayColor];
                [self.twoButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [self.threeButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
            }];
          

        }
            break;
        case 3:
        {
            [UIView animateWithDuration:0.3 animations:^{
                [self.oneButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                [self.Button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                self.animationView1.backgroundColor = [UIColor lightGrayColor];
                self.animationView2.backgroundColor = [UIColor lightGrayColor];
                self.animationView.backgroundColor = [UIColor lightGrayColor];
                self.animationView3.backgroundColor = [UIColor redColor];
                [self.twoButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
                [self.threeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

            }];
        }
            break;
        default:
            break;
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(withUserIndex:index:)]) {
        [self.delegate withUserIndex:self index:one.tag];
    }

}
- (void)layoutSubviews {
    self.Button.frame = CGRectMake(10, 0, 100, self.height);

    self.oneButton.frame = CGRectMake(self.Button.maxX+5, 0, (self.width-130)/3.0, self.height);
    self.twoButton.frame = CGRectMake(self.oneButton.maxX+5, 0, (self.width-130)/3.0, self.height);
    self.threeButton.frame = CGRectMake(self.twoButton.maxX+5, 0,(self.width-130)/3.0, self.height);
    self.animationView.frame = CGRectMake(10, self.height-6,100, 1);
    self.animationView1.frame = CGRectMake(self.Button.maxX+5, self.height-6,self.oneButton.width, 1);
    self.animationView2.frame = CGRectMake(self.oneButton.maxX+5, self.height-6,self.twoButton.width, 1);
    self.animationView3.frame = CGRectMake(self.twoButton.maxX+5, self.height-6,self.threeButton.width, 1);

}

@end
