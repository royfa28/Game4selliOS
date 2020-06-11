//
//  OrderHistoryViewController.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 11/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderHistory.h"

@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface OrderHistoryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *data;

@end

NS_ASSUME_NONNULL_END
