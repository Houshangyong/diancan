//
//  HNCFLoginViewController.m
//  HNCF
//
//  Created by houshangyong on 15/11/21.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFLoginViewController.h"
#import "HNCFCommmon.h"

@interface HNCFLoginViewController ()<HNCFNaViewDelegate>
@property (nonatomic , strong) HNCFNaView *naView;

@end

@implementation HNCFLoginViewController
- (HNCFNaView *)naView
{
    if (!_naView) {
        _naView = [[HNCFNaView alloc]initWithFrame:CGRectMake(0, 20, HNCFWidth, 44)];
        _naView.delegate = self;
    }
    return _naView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [HNCF_APP_DELEGATE.tabBarController setTabBarHidden:YES];
//    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];

    self.phoneView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.pswView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.phoneView.layer.borderWidth = 1.0f;
    self.pswView.layer.borderWidth = 1.0f;
    self.phoneView.layer.cornerRadius = 5.0f;
    self.pswView.layer.cornerRadius = 5.0f;
    self.resigetButton.layer.cornerRadius = 5.0f;
    self.loginButton.layer.cornerRadius = 5.0f;
        [self.naView setHomeBannerData:@"登录" locationImage:YES rightButton:YES leftButton:NO rightImage:[UIImage imageNamed:@""]];
        self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.naView];

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
#pragma mark - 忘记密码
- (IBAction)forgetPswButton:(id)sender;
{
    HNCFForgetPswViewController *forgetPswViewController = [[HNCFForgetPswViewController alloc]init];
    [self.navigationController pushViewController:forgetPswViewController animated:YES];
}
#pragma mark - 登陆
- (IBAction)loginButton:(id)sender;
{
    if ([FileOperation isValidatePhone:self.phoneText.text]) {
        if ([self.pswText.text length]>=6&&[self.pswText.text length]<=16) {
            [HNCFRequestManager fetchLogin:@{@"mobile":self.phoneText.text,@"password":self.pswText.text} success:^(id result) {
                NSLog(@"result::%@",result);
                NSInteger status = [[result objectForKey:@"code"]integerValue];
                if (status ==0) {
                    [MJProgressHUD showHUDWithText:@"登陆成功" duration:1.0];
                    [HNCFUserDefaultsUtil setGlobalObject:@{@"uid":[[result objectForKey:@"result"] objectForKey:@"uid"],@"mobile":[[result objectForKey:@"result"] objectForKey:@"mobile"],@"username":[NSString stringWithFormat:@"%@",[[result objectForKey:@"result"] objectForKey:@"username"]],@"img":[NSString stringWithFormat:@"%@%@",HNCF_IMAGE_URL,[[result objectForKey:@"result"] objectForKey:@"img"]]} forKey:kMTCurrentUserInfo];
                    
                    if ([self.status isEqualToString:@"1"]) {
                        [HNCF_APP_DELEGATE.tabBarController switchToViewControllerAtIndex:0];
                        
                        [self dismissViewControllerAnimated:YES completion:^{
                        }];
                    }else{
                        
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
                else{
                    [MJProgressHUD showHUDWithText:[result objectForKey:@"msg"] duration:1.0];
                }
                
            } failure:^(NSError *error) {
                
            }];
        }else{
            [MJProgressHUD showHUDWithText:@"密码长度不够" duration:1.0];

        }
    }
   
}
- (IBAction)resigetButton:(id)sender;
{
    HNCFResigetViewController *resigetViewController = [[HNCFResigetViewController alloc]init];
    [self.navigationController pushViewController:resigetViewController animated:YES];
}
- (void)didSelectLeft;
{
    if ([self.status isEqualToString:@"1"]) {
        [HNCF_APP_DELEGATE.tabBarController switchToViewControllerAtIndex:0];

        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }else{
        
    [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)didSelectRight;
{
    
}
@end
