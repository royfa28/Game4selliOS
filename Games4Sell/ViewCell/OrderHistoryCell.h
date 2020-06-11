//
//  OrderHistoryCell.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 11/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderHistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderDetailLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;

@end

NS_ASSUME_NONNULL_END
