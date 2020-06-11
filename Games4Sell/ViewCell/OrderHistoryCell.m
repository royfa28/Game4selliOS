//
//  OrderHistoryCell.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 11/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "OrderHistoryCell.h"

@implementation OrderHistoryCell

@synthesize orderDateLbl, orderDetailLbl, totalPriceLbl;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
