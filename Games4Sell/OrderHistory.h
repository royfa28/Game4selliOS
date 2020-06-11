//
//  OrderHistory.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 11/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderHistory : NSObject


@property NSString *orderDate;
@property NSString *details;
@property NSNumber *totalPrice;

@end

NS_ASSUME_NONNULL_END
