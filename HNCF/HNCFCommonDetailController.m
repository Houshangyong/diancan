//
//  HNCFCommonDetailController.m
//  HNCF
//
//  Created by Apple on 16/3/2.
//  Copyright © 2016年 hsy. All rights reserved.
//

#import "HNCFCommonDetailController.h"
#import "HNCFCommmon.h"

@interface HNCFCommonDetailController ()<HNCFNaViewDelegate,HNCFHeadBrandViewDelegate>
@property (nonatomic , strong) HNCFNaView *naView;
@property (nonatomic , strong) HNCFHeadBrandView *headBrandView;
@property (nonatomic , strong) UIButton *backButton;
@property (nonatomic , strong) UIScrollView *mainScrollView;
@property (nonatomic , strong) HNCFHomeDetailVIew *MiddleView;
@property (nonatomic , strong) id modell;
@property (nonatomic , strong) UIImageView *headImageView;

@end
/*
 [HNCFRequestManager fetchhomeshopDetail:@{@"id":self.idString} success:^(id result) {
 NSInteger status = [[result objectForKey:@"code"]integerValue];
 if (status ==0) {
 self.modell = [result objectForKey:@"result"];
 
 }
 } failure:^(NSError *error) {
 
 }];

 */
@implementation HNCFCommonDetailController
- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, HNCFWidth, HNCFHeight-64)];
        
    }
    return _mainScrollView;
}
- (HNCFNaView *)naView
{
    if (!_naView) {
        _naView = [[HNCFNaView alloc]initWithFrame:CGRectMake(0, 20, HNCFWidth, 44)];
        _naView.delegate = self;
    }
    return _naView;
}
- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HNCFWidth, HNCFWidth/2)];
        
    }
    return _headImageView;
}
- (HNCFHeadBrandView *)headBrandView
{
    if (!_headBrandView) {
        _headBrandView = [[HNCFHeadBrandView alloc]initWithFrame:CGRectMake(0, self.headImageView.maxY, HNCFWidth, HNCFWidth/2)];
        _headBrandView.delegate = self;
        _headBrandView.backgroundColor = [UIColor clearColor];
    }
    return _headBrandView;
}
- (HNCFHomeDetailVIew *)MiddleView
{
    if (!_MiddleView) {
        _MiddleView = [[HNCFHomeDetailVIew alloc]initWithFrame:CGRectMake(0, self.headBrandView.maxY, HNCFWidth, HNCFWidth)];
        _MiddleView.backgroundColor = [UIColor clearColor];
    }
    return _MiddleView;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HNCF_APP_DELEGATE.tabBarController setTabBarHidden:YES];
    self.navigationController.navigationBarHidden = NO;

  }
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.naView setHomeBannerData:@"菜单详情" locationImage:YES rightButton:YES leftButton:NO rightImage:[UIImage imageNamed:@""]];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.naView];
    
    [HNCFRequestManager fetchhomeshopDetail:@{@"id":self.idString} success:^(id result) {
        NSInteger status = [[result objectForKey:@"code"]integerValue];
        if (status ==0) {
            self.modell = [[result objectForKey:@"result"] objectAtIndex:0];
            NSLog(@"%@",[self.modell objectForKey:@"picarr"]);
            if ([[self.modell objectForKey:@"picarr"]isEqualToString:@"a:0:{}"]){
                
            }else{

            NSString *pic = [[self.modell objectForKey:@"picarr"] stringByReplacingOccurrencesOfString:@"a:" withString:@""];
            pic = [pic stringByReplacingOccurrencesOfString:@"}" withString:@""];
            pic = [pic stringByReplacingOccurrencesOfString:@"{" withString:@""];
            
            
            for (int i =0; i<[[pic substringWithRange:NSMakeRange(0, 1)]integerValue]; i++) {
                
                pic = [pic stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"i:%d;s:35:",i] withString:@""];
            }
            pic = [pic stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",[pic substringWithRange:NSMakeRange(0, 1)]] withString:@""];
            pic = [pic stringByReplacingOccurrencesOfString:@":" withString:@""];
            pic = [pic stringByReplacingOccurrencesOfString:@"\"" withString:@""];

            NSArray *arrayPic = [pic componentsSeparatedByString:@";"];
            NSLog(@"str==%@",[arrayPic objectAtIndex:0]);
            [self.headBrandView setHomeBannerData:arrayPic isWho:@"1"];
            }
              [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HNCF_IMAGE_URL,[self.modell objectForKey:@"thumb"]]]];

            [self.MiddleView HNCFHomeDetailVIew:self.modell];
            
            [self.view addSubview:self.mainScrollView];
            [self.mainScrollView addSubview:self.headImageView];

            [self.mainScrollView addSubview:self.headBrandView];
            [self.mainScrollView addSubview:self.MiddleView];
            // 测试字串
            NSString *s = [self.modell objectForKey:@"description"];
            UIFont *font = [UIFont fontWithName:@"Arial" size:12];
            //设置一个行高上限
            CGSize size = CGSizeMake(320,2000);
            //计算实际frame大小，并将label的frame变成实际大小
            CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
            self.MiddleView.frame = CGRectMake(0, self.headBrandView.maxY, HNCFWidth, HNCFWidth/2+75+labelsize.height);
            self.mainScrollView.contentSize = CGSizeMake(0, self.MiddleView.maxY+30);
        }
    } failure:^(NSError *error) {
        
    }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didSelectLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didSelectRight
{
    
}
#pragma
#pragma mark - HNCFHeadBrandViewDelegate
- (void)HNCFHeadBrandView:(HNCFHeadBrandView *)bannerView didSelectItem:(NSDictionary *)itemData Index:(NSInteger)index;
{
    
}


@end