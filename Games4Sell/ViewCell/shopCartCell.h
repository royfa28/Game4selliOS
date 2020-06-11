//
//  shopCartCell.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 10/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface shopCartCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cartImage;
@property (weak, nonatomic) IBOutlet UILabel *cartName;
@property (weak, nonatomic) IBOutlet UILabel *cartPrice;
@property (weak, nonatomic) IBOutlet UILabel *cartQuantity;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIButton *minBtn;
@property (weak, nonatomic) IBOutlet UIButton *plusBtn;


@end

NS_ASSUME_NONNULL_END
