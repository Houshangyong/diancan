//
//  HNCFPayViewController.h
//  HNCF
//
//  Created by Apple on 15/12/23.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HNCFPayViewController : UIViewController
@property (nonatomic ,strong) IBOutlet UILabel *label;
@property (nonatomic ,strong) IBOutlet UIButton *paybtn;
@property (nonatomic , strong) NSString *shouhuoRen;
@property (nonatomic , strong) NSString *address;
@property (nonatomic , strong) NSString *price;
@property (nonatomic , strong) NSString *orderId;
@property (nonatomic , strong) NSString *foodname;

@property (nonatomic ,strong) IBOutlet UIButton *paybtn11;
@property (nonatomic ,strong) IBOutlet UIButton *paybtn22;
- (IBAction)payButton22:(id)sender;


- (IBAction)payButton:(id)sender;
@end
