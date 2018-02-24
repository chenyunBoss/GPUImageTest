//
//  CollectionViewCell.m
//  GPUImageTest
//
//  Created by chenyun on 2018/1/22.
//  Copyright © 2018年 yctc. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.contentLab.layer.cornerRadius = 0.5;
    self.contentLab.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.contentLab.layer.borderWidth = 0.5;
}

@end
