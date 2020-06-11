//
//  shoppingCartViewController.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 10/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface shoppingCartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;

@property (weak, nonatomic) IBOutlet UIButton *paymentBtn;
@property FIRFirestore *db;
@property FIRCollectionReference *cartColRef;

- (IBAction)checkoutBtn:(id)sender;
- (IBAction)payBtn:(id)sender;


@end

NS_ASSUME_NONNULL_END
