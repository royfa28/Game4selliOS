//
//  ProductTableViewController.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 3/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "ProductDetailViewController.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface ProductTableViewController : UITableViewController

@property (nonatomic) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
