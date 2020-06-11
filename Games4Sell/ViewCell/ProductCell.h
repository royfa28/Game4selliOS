//
//  ProductCell.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 3/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productPlatform;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;

@end

NS_ASSUME_NONNULL_END
