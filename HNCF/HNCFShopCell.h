//
//  HNCFShopCell.h
//  HNCF
//
//  Created by houshangyong on 15/11/22.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HNCFCommmon.h"
#import "HNCFButton.h"
#import "HNCFFoodListModel.h"
@interface HNCFShopCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView *imageVIew;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *subNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) IBOutlet UILabel *num;
@property (nonatomic, strong) IBOutlet HNCFButton *addButton;
@property (nonatomic, strong) IBOutlet HNCFButton *jianButton;
@property (nonatomic, strong) IBOutlet HNCFButton *xuanBtn;
@property(assign,nonatomic)BOOL selectState;//选中状态


- (void)setCellContent:(HNCFFoodListModel *)dataModel indexPath:(NSIndexPath *)indePath;
- (void)setCellIndexPath:(NSIndexPath *)indePath isSelected:(BOOL)selected;

@end
