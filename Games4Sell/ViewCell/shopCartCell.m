//
//  shopCartCell.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 10/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "shopCartCell.h"

@implementation shopCartCell

@synthesize cartName, cartImage, cartPrice, cartQuantity;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
