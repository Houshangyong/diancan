//
//  HNCFFeedViewController.h
//  HNCF
//
//  Created by houshangyong on 15/11/23.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCFCommmon.h"

@interface HNCFFeedViewController : UIViewController
@property (nonatomic ,strong) IBOutlet MTPlaceholderTextView *textView;
@property (nonatomic ,strong) IBOutlet UIButton *Button;
- (IBAction)feedButton:(id)sender;
@end
