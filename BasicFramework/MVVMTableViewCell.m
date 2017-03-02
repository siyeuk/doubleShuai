//
//  MVVMTableViewCell.m
//  BasicFramework
//
//  Created by 我叫哀木涕 on 2017/2/28.
//  Copyright © 2017年 我叫哀木涕. All rights reserved.
//

#import "MVVMTableViewCell.h"

@implementation MVVMTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
