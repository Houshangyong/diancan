//
//  HNCFMZViewController.m
//  HNCF
//
//  Created by Apple on 15/12/24.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFMZViewController.h"
#import "HNCFCommmon.h"

@interface HNCFMZViewController ()
<HNCFNaViewDelegate>
@property (nonatomic , strong) HNCFNaView *naView;
@end

@implementation HNCFMZViewController
- (HNCFNaView *)naView
{
    if (!_naView) {
        _naView = [[HNCFNaView alloc]initWithFrame:CGRectMake(0, 20, HNCFWidth, 44)];
        _naView.delegate = self;
    }
    return _naView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.naView setHomeBannerData:@"用户协议" locationImage:YES rightButton:YES leftButton:NO rightImage:[UIImage imageNamed:@""]];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.naView];
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)didSelectLeft;
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didSelectRight;
{
    
}
@end
