//
//  HNCFHomeDetailVIew.m
//  HNCF
//
//  Created by houshangyong on 15/12/20.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFHomeDetail.h"
#import "HNCFCommmon.h"

@interface HNCFHomeDetail ()
@property (nonatomic ,strong) UILabel *nameLabel;
@property (nonatomic ,strong) UIView *detailView;
@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) UILabel *detailLabel;
@property (nonatomic ,strong) UIImageView *healthImage;
@property (nonatomic ,strong) UILabel *detailLabel1;
@property (nonatomic ,strong) UIButton *Buttton;
@property (nonatomic , strong) id model;

@property (nonatomic ,strong) UIView *footView;
@property (nonatomic ,strong) UIImageView *footImage;
@property (nonatomic ,strong) UILabel *footLabel;

@end

@implementation HNCFHomeDetail
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.width, 30)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:16.0f];
    }
    return _nameLabel;
}
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}
- (UIView *)detailView
{
    if (!_detailView) {
        _detailView = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailView.layer.borderWidth = 1.0;
        _detailView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    }
    return _detailView;
}
- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        _detailLabel.font = [UIFont systemFontOfSize:12.0f];
        _detailLabel.textColor = [UIColor darkTextColor];
        
    }
    return _detailLabel;
}
- (UILabel *)detailLabel1
{
    if (!_detailLabel1) {
        _detailLabel1 = [[UILabel alloc]initWithFrame:CGRectZero];
        _detailLabel1.textAlignment = NSTextAlignmentCenter;
        _detailLabel1.font = [UIFont systemFontOfSize:12.0f];
        _detailLabel1.textColor = [UIColor darkTextColor];
        
    }
    return _detailLabel1;
}
- (UIImageView *)healthImage
{
    if (!_healthImage) {
        _healthImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _healthImage;
}
- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _footView;
}
- (UILabel *)footLabel
{
    if (!_footLabel) {
        _footLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _footLabel.textAlignment = NSTextAlignmentCenter;
        _footLabel.font = [UIFont systemFontOfSize:14.0f];
        _footLabel.textColor = [UIColor redColor];
        
    }
    return _footLabel;
}
- (UIImageView *)footImage
{
    if (!_footImage) {
        _footImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _footImage;
}
- (UIButton *)Buttton
{
    if (!_Buttton) {
        _Buttton = [UIButton buttonWithType:UIButtonTypeCustom];
     [_Buttton bk_addEventHandler:^(id sender) {
         [self buttonSlect];
     } forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _Buttton;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.nameLabel];
        [self addSubview:self.detailLabel1];
        [self.detailView addSubview:self.titleLabel];
        [self addSubview:self.detailView];
        [self.detailView addSubview:self.detailLabel];
        [self.detailView addSubview:self.healthImage];
        [self addSubview:self.Buttton];

        [self addSubview:self.footView];
        [self.footView addSubview:self.footImage];
        [self.footView addSubview:self.footLabel];

        
    }
    return self;
}

- (void)HNCFHomeDetailVIew1:(id)model comentCount:(NSArray *)array;
{
    self.model = model;
    self.nameLabel.frame = CGRectMake(0, 10, self.width, 30);
    [self.detailLabel1 setNumberOfLines:0];
    self.detailLabel1.lineBreakMode = NSLineBreakByCharWrapping;
    // 测试字串
    NSString *s1 = [model objectForKey:@"sl_description"];
    UIFont *font1 = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size1 = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize1 = [s1 sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByCharWrapping];
    self.detailLabel1.frame = CGRectMake(10, self.nameLabel.maxY, self.width-20, labelsize1.height+20);
    self.detailLabel1.text = s1;
    
    [self.detailLabel setNumberOfLines:0];
    self.detailLabel.lineBreakMode = NSLineBreakByCharWrapping;
    // 测试字串
    NSString *s = [model objectForKey:@"description"];
    UIFont *font = [UIFont fontWithName:@"Arial" size:12];
    //设置一个行高上限
    CGSize size = CGSizeMake(320,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    self.titleLabel.frame = CGRectMake(0, 5, self.width, 20);

    self.detailLabel.frame = CGRectMake(60, self.titleLabel.maxY, self.width-90, labelsize.height+30);
    self.detailLabel.text = s;
    self.titleLabel.frame = CGRectMake(0, 5, self.width, 20);
    self.detailView.frame = CGRectMake(10, self.detailLabel1.maxY+5, self.width-20, self.detailLabel.height+20);
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"sl_title"]];
    self.titleLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"title"]];
    self.healthImage.frame = CGRectMake(10, 10, 40, 40);
    self.healthImage.y = self.detailView.height/2-20;
    self.healthImage.layer.cornerRadius = 20;
    self.healthImage.layer.masksToBounds = YES;
    [self.healthImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HNCF_IMAGE_URL,[model objectForKey:@"thumb"]]] placeholderImage:nil];
    self.Buttton.frame = self.detailView.frame;
    self.footView.frame = CGRectMake((self.width-150)/2, self.detailView.maxY+10, 150, 30);
    self.footView.layer.cornerRadius = 5;
    self.footView.layer.borderColor = [[UIColor redColor]CGColor];
    self.footView.layer.borderWidth = 0.5;
    self.footImage.frame = CGRectMake(10, 5, 20, 20);
    self.footImage.image = [UIImage imageNamed:@"ic_comment"];
    self.footLabel.frame = CGRectMake(self.footLabel.maxY+5, 5, self.footView.width-30, 20);
    if ([array count]==0) {
        self.footView.hidden = YES;
    }else{
        self.footView.hidden = NO;
        self.footLabel.text = [NSString stringWithFormat:@"共%ld条评论",[array count]];
    }
    

}
- (void)buttonSlect
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(HNCFHomeDetailIndex:index:)]) {
        [self.delegate HNCFHomeDetailIndex:self index:self.model];
    }
}
@end