//
//  OrderHistoryViewController.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 11/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "OrderHistoryCell.h"

@interface OrderHistoryViewController ()

@end

@implementation OrderHistoryViewController{
    NSMutableArray<FIRDocumentSnapshot *> *orderHistory;
}
@synthesize data, tableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    data = [[NSMutableArray alloc] init];
    
    NSString *uid;
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user){
        uid = user.uid;
    }
    
    FIRFirestore *db = FIRFirestore.firestore;
    FIRCollectionReference *historyRef = [[[db collectionWithPath:@"Users"] documentWithPath:uid] collectionWithPath:@"Orders"];
    
    [historyRef getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError *error) {
        if( snapshot == nil ){
            NSLog(@"Error fetching document: %@", error);
        }else{
            for (FIRDocumentSnapshot *doc in snapshot.documents){
                self->orderHistory = [snapshot.documents copy];
                [self->data addObject:doc.data];
//                NSLog(@"%@", self->orderHistory);
                [self.tableView reloadData];
            }
        }
    }];
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderHistoryCell *cell = (OrderHistoryCell *)[tableView dequeueReusableCellWithIdentifier:@"orderHistory"];
    
    FIRDocumentSnapshot *history = orderHistory[indexPath.row];
    
    cell.orderDetailLbl.text = history[@"details"];
    cell.orderDateLbl.text = [NSString stringWithFormat: @"Order date: %@", history[@"orderDate"]];
    cell.totalPriceLbl.text = [NSString stringWithFormat: @"Total price: $%@", history[@"totalPrice"]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
