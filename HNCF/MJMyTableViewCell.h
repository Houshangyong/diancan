//
//  MJMyTableViewCell.h
//  mj
//
//  Created by Apple on 15/7/7.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJMyTableViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imageVIew;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *subNameLabel;

@end
