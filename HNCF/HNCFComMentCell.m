//
//  HNCFComMentCell.m
//  HNCF
//
//  Created by Apple on 15/12/29.
//  Copyright © 2015年 hsy. All rights reserved.
//

#import "HNCFComMentCell.h"
#import "HNCFCommmon.h"

@implementation HNCFComMentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)comment:(id)model;
{
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HNCF_IMAGE_URL,[model objectForKey:@"img"]]] placeholderImage:nil];
    self.topImageView.layer.cornerRadius = 17.5f;
    self.topImageView.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.topImageView.layer.borderWidth = 0.5f;
    self.topImageView.layer.masksToBounds = YES;
    self.contentLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"sd_content"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",[model objectForKey:@"mobile"]];

}
@end
