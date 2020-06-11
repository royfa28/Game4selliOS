//
//  ProductCell.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 3/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell

@synthesize productPlatform, productPrice, productName;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
