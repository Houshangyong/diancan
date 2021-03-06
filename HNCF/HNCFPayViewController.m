//
//  HNCFPayViewController.m
//  HNCF
//
//  Created by Apple on 15/12/23.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFPayViewController.h"
#import "HNCFCommmon.h"
#import "payRequsestHandler.h"
#import "UIDevice+mtgj.h"

@interface HNCFPayViewController ()<HNCFNaViewDelegate>
@property (nonatomic , strong) HNCFNaView *naView;
@property (nonatomic , strong) NSString *payString;
@property (nonatomic , strong) NSString *orderNo;

@end

@implementation HNCFPayViewController
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
    self.payString = @"0";
    [HNCF_APP_DELEGATE.tabBarController setTabBarHidden:YES];
    self.navigationController.navigationBarHidden = NO;

    if([WXApi isWXAppInstalled]) // 判断 用户是否安装微信
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];//监听一个通知
    }
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.naView setHomeBannerData:@"订单支付" locationImage:YES rightButton:YES leftButton:NO rightImage:[UIImage imageNamed:@""]];
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithCustomView:self.naView];
   
//    self.label.text = [NSString stringWithFormat:@"收货人: %@\n配送地址: %@\n总金额: ￥%.2f\n应付金额: ￥%.2f",self.shouhuoRen,self.address, [self.price floatValue], [self.price floatValue]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 通知信息
- (void)getOrderPayResult:(NSNotification *)notification{
    static dispatch_once_t disOnce;
    dispatch_once(&disOnce,  ^ {
        if ([notification.object isEqualToString:@"success"])
        {
            
//            [HNCFRequestManager fetchPayOrder:@{@"id":self.orderId} success:^(id result) {
//                NSInteger code = [[result objectForKey:@"code"]integerValue];
//                if (code == 0 ) {
//                    [self.navigationController popToRootViewControllerAnimated:YES];
//                    [MJProgressHUD showHUDWithText:@"支付成功" duration:1.0];
//
//                }
//            } failure:^(NSError *error) {
//                
//            }];
            [MJProgressHUD showHUDWithText:@"支付成功" duration:1.0];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            
            [MJProgressHUD showHUDWithText:@"支付失败" duration:1.0];
            
            
        }
    });
}

- (IBAction)payButton:(id)sender
{
    self.orderNo = [self generateTradeNO];
    if ([self.payString isEqualToString:@"0"]) {
        //本实例只是演示签名过程， 请将该过程在商户服务器上实现
        
        //创建支付签名对象
        payRequsestHandler *req = [payRequsestHandler alloc];
        //初始化支付签名对象
        [req init:APP_ID mch_id:MCH_ID];
        //设置密钥
        [req setKey:PARTNER_ID];
        
        //}}}[NSString stringWithFormat:@"%ld",[stringPrice integerValue]*100]
        NSLog(@"%@",self.price);
        NSString *stringPrice = [self.price stringByReplacingOccurrencesOfString:@"共" withString:@""];
        stringPrice = [stringPrice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
        NSString *strPrice = [NSString stringWithFormat:@"%f",[stringPrice doubleValue]*100] ;
//        self.wxorderNo = [NSString stringWithFormat:@"%ld",time(0)];
        //获取到实际调起微信支付的参数后，在app端调起支付
        NSMutableDictionary *dict = [req getPrepayWithOrderName:self.foodname price:[NSString stringWithFormat:@"%d",[strPrice intValue]]
                                     
                                                         device:[[UIDevice currentDevice] mtgj_UUID] orderNO: self.orderNo notify:NOTIFY_URL];
        
        if(dict == nil){
            //错误提示
            NSString *debug = [req getDebugifo];
            [MJProgressHUD showHUDWithText:debug duration:1.0];
            NSLog(@"%@\n\n",debug);
        }else{
            NSLog(@"%@\n\n",[req getDebugifo]);
            //[self alert:@"确认" msg:@"下单成功，点击OK后调起支付！"];
            
            NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.openID              = [dict objectForKey:@"appid"];
            req.partnerId           = [dict objectForKey:@"partnerid"];
            req.prepayId            = [dict objectForKey:@"prepayid"];
            req.nonceStr            = [dict objectForKey:@"noncestr"];
            req.timeStamp           = stamp.intValue;
            req.package             = [dict objectForKey:@"package"];
            req.sign                = [dict objectForKey:@"sign"];
            
            [WXApi sendReq:req];
        }
        
}else{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    NSString *partner = @"2088911958767768";
    NSString *seller = @"mmhncf@vip.163.com";
    NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOicP3OBCSFF7nfNEwd1XmD1VL+3FQHaxDO+XzG1EsZ/fCQhnpnla2KUOqD9lHWHYidzO0fr1Tk8450qV9YdEfSjrSplPGQS7+zSqzvNwJVCgBECukQOeqJ3Z56mmp2X0TCyi0lxG4hfg0LkB5Hubj0RAzttM/pVwvKvvxTMpaQ1AgMBAAECgYAfh0YmbsABDYyEGnzQzvzK4ZXqInOre66KYOxgPW3dD9yQvSnVLD6A7xx/Q7/CqmYIeNr5JaMSDgm//MRJFkmff/LiT4cnpDkeGPRriu66p5QlAeAgM0kiedIzpYVXdk6+2qkKf9IPapVj2A+5nS21kXsWGySuanWk47Y1dg5uhQJBAP+SOKIQ+nTL2gmcuRPSG2geH16hN//UvkVnPnusi5QsRZV9hmgrhLd4Eil7r+154f4OQP1h6MX+GaifQAed3YsCQQDpACn5/7fLBOkjw6cze46uLg16y9asInuy1QSs0WVXIIwzVXzsC3F3qXs2id/12Y+xNmjWDEu+R/5POhSRRj0/AkAO6ojVpKoJgRBTuUrwBjZFSGTKUByFmPQV9uWlsDdhSYgyJmZe1BNl5eMheq+U66Ut/8T5ROqiC6eRuOGy0BrrAkAOPvNSFL+BCzjR9fl4HVrY7XnngyUJ+0XC5mFVy6u9iwDndpefuwdiAJvG9uEZoAa4GBKK28+Zv78dyvhM9ZVzAkEA1JqjgrhbkQvpqvVdZA05VA1TG5KgioDu7vovglqpvy2pWeAYQksxGbA780p4I0mYbh3au4B6lxYCi26vPPjTRQ==";
    NSString *stringPrice = [self.price stringByReplacingOccurrencesOfString:@"￥" withString:@""];
    stringPrice = [stringPrice stringByReplacingOccurrencesOfString:@"共" withString:@""];

    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = self.orderNo; //订单ID（由商家自行制定）
    order.productName =  self.foodname; //商品标题
    order.productDescription =@"nihao"; //商品描述
    //order.amount = stringPrice; //商品价格
    
    order.amount = stringPrice;
    order.notifyURL = [NSString stringWithFormat:@"%@order/payCompleteBack.do",HNCF_APP_URL]; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"mmcf";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            if ([[resultDic objectForKey:@"resultStatus"]isEqualToString:@"9000"]) {
                
//                [HNCFRequestManager fetchPayOrder:@{@"id":self.orderId} success:^(id result) {
//                    NSInteger code = [[result objectForKey:@"code"]integerValue];
//                    if (code == 0 ) {
//                        [self.navigationController popToRootViewControllerAnimated:YES];
//                    }else{
//                        [MJProgressHUD showHUDWithText:@"支付失败" duration:1.0];
//                    }
//                } failure:^(NSError *error) {
//                    
//                }];
                [MJProgressHUD showHUDWithText:@"支付成功" duration:1.0];

                [self.navigationController popToRootViewControllerAnimated:YES];

                
            }
        }];
    }
    }
}
#pragma mark -
#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}
- (void)didSelectLeft;
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didSelectRight;
{
    
}
- (IBAction)payButton22:(id)sender;
{
    if ([sender tag]==0 ) {
        self.payString = @"0";
        [self.paybtn11 setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];
        [self.paybtn22 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];

    }else{
        self.payString = @"1";
        [self.paybtn11 setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.paybtn22 setImage:[UIImage imageNamed:@"2"] forState:UIControlStateNormal];


    }
}
@end
