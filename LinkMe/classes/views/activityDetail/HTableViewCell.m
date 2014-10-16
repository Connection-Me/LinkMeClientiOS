//
//  HTableViewCell.m
//  LinkMe
//
//  Created by ChaoSo on 14-10-13.
//  Copyright (c) 2014年 Summer.Wu. All rights reserved.
//

#import "HTableViewCell.h"

@implementation HTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)updateCell:(ActivityModel *) sampleActivityModel{
    
    self.approveNameLabel.text = @"Messi is approved";
    self.approveNameLabel.textColor = [UIColor whiteColor];
    self.approveUserImage.image = [UIImage imageNamed:@"user1.jpg"];
    [self setBackgroundColor:[UIColor clearColor]];
    
}




@end
