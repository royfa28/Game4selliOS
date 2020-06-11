//
//  Product.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 3/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Product : NSObject

@property NSString *Description;
@property NSString *Genre;
@property NSString *Name;
@property NSString *Platform;
@property NSString *photoUrl;
@property NSNumber *Price;

@end

NS_ASSUME_NONNULL_END
