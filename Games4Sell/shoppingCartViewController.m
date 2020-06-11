//
//  shoppingCartViewController.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 10/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "shoppingCartViewController.h"
#import "shopCartCell.h"

@interface shoppingCartViewController ()

@end

@implementation shoppingCartViewController{
    NSMutableArray<FIRDocumentSnapshot *> *_shopCart;
    double totalPrice, allPrice;
    NSString *orderList;
}

NSString *uid;

@synthesize data, tableView, totalPriceLabel, paymentBtn, db, cartColRef;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Get current user
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user){
        uid = user.uid;
    }
    
    totalPriceLabel.text = @"Total price: $0";
    allPrice = 0;
    orderList = @"";
    [paymentBtn setTitle:[NSString stringWithFormat:@"Pay $%.2f", self->allPrice] forState:UIControlStateNormal];
    
    db = FIRFirestore.firestore;
    cartColRef = [[[db collectionWithPath:@"Users"] documentWithPath:uid] collectionWithPath:@"shoppingCart"];
    
    [self getCart];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    shopCartCell *cell = (shopCartCell *)[tableView dequeueReusableCellWithIdentifier:@"shopCart"];
       
    FIRDocumentSnapshot *cart = _shopCart[indexPath.row];
    
    cell.cartName.text = cart[@"Name"];
    cell.cartPrice.text = [NSString stringWithFormat:@"$ %@", cart[@"Price"]];
    cell.cartQuantity.text = [NSString stringWithFormat:@"Q: %@", cart[@"Quantity"]];
    
    // Add action to the button
    [cell.deleteBtn addTarget:self action:@selector(delete :) forControlEvents:UIControlEventTouchUpInside];
    [cell.minBtn addTarget:self action:@selector(minus :) forControlEvents:UIControlEventTouchUpInside];
    [cell.plusBtn addTarget:self action:@selector(plus :) forControlEvents:UIControlEventTouchUpInside];
    
    //Get image URL
    NSString *result = cart[@"photoUrl"];
    NSData *imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString:result]];
    cell.cartImage.image = [UIImage imageWithData:imageData];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 108;
}

#pragma mark - Firestore function
- (void)delete:(id)sender{
    
    // Get index of row clicked
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:touchPoint];
    
    // Initialize the cart
    FIRDocumentSnapshot *cart = _shopCart[indexPath.row];
    NSLog(@"Doc id :%@", [cart documentID]);
    
    [[cartColRef documentWithPath:[cart documentID]] deleteDocumentWithCompletion:^(NSError *error) {
        if (error != nil){
            NSLog(@"Error removing document: %@", error);
        }else{
            NSLog(@"Document removed");
            self->allPrice = 0;
            self->orderList = @"";
            [self cartRemoved];
        }
    }];
}

-(void)minus:(id)sender{
    // Get index of row clicked
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:touchPoint];
    
    FIRDocumentSnapshot *cart = _shopCart[indexPath.row];
    
    int quantity = [cart[@"Quantity"] intValue];
    
    if( quantity <= 1){
        [[cartColRef documentWithPath:[cart documentID]] deleteDocumentWithCompletion:^(NSError *error) {
            if (error != nil){
                NSLog(@"Error removing document: %@", error);
            }else{
                NSLog(@"Document removed");
                self->allPrice = 0;
                self->orderList = @"";
                [self cartRemoved];
            }
        }];
    }else {
        [[cartColRef documentWithPath:[cart documentID]] updateData:@{
            @"Quantity": @(quantity -1)
        }completion:^(NSError *error) {
            if (error != nil){
                
            }else{
                NSLog(@"Product decreased");
                self->allPrice = 0;
                self->orderList = @"";
                [self getCart];
            }
        }];
    }
}

-(void)plus:(id)sender{
    // Get index of row clicked
    CGPoint touchPoint = [sender convertPoint:CGPointZero toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:touchPoint];
    
    FIRDocumentSnapshot *cart = _shopCart[indexPath.row];
    
    int quantity = [cart[@"Quantity"] intValue];
    
    if( quantity >= 3){
        [self maxAmount];
    }else {
        [[cartColRef documentWithPath:[cart documentID]] updateData:@{
            @"Quantity": @(quantity + 1)
        }completion:^(NSError *error) {
            if (error != nil){
                [self genericError:[NSString stringWithFormat:@"%@", error]];
            }else{
                NSLog(@"Product added");
                self->allPrice = 0;
                self->orderList = @"";
                [self getCart];
            }
        }];
    }
}

- (void)getCart{
    
    data = [[NSMutableArray alloc] init];

//    FIRCollectionReference *cartColRef =[[[db collectionWithPath:@"Users"] documentWithPath:uid] collectionWithPath:@"shoppingCart"];
    
    [cartColRef getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError * _Nullable error) {
        if(snapshot == nil){
            [self genericError:[NSString stringWithFormat:@"Error fetching document: %@", error]];
        }else{
            
            for (FIRDocumentSnapshot *document in snapshot.documents){
                self->_shopCart = [snapshot.documents copy];
                
                double price = [document[@"Price"] doubleValue];
                double quantity = [document[@"Quantity"] doubleValue];
                self->totalPrice = price * quantity;
                [self getTotalPrice:self->totalPrice];
                [self getOrderList:document[@"Name"] :[document[@"Quantity"] doubleValue]];
                [self-> data addObject:document.data];
                [self.tableView reloadData];
            }
        }
    }];
}

-(void)getTotalPrice:(double )price{
    self->allPrice = price + self->allPrice;
    totalPriceLabel.text = [NSString stringWithFormat:@"Total price: $ %.2f", self->allPrice];
//    NSLog(@"ALL price %f", self->allPrice);
}

-(void)getOrderList:(NSString *)name : (double ) quantity{
    self->orderList = [NSString stringWithFormat:@"%@ x %.2f %@, ", name, quantity, self->orderList];
//    NSLog(@"All order: %@", self->orderList);
}

#pragma mark - UI AlertView methods

-(void)cartRemoved{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
        message:@"Product has been removed"
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        [self getCart];
    }];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)maxAmount{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
        message:@"You can only buy 3 of the same products"
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        [self getCart];
    }];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)genericError:(NSString *)strmessage{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
        message: strmessage
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        [self getCart];
    }];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)purchased{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Thanks!"
        message:@"Thank you for shopping with us"
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
        [self getCart];
    }];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Write to database, delete all
- (IBAction)checkoutBtn:(id)sender {
    shoppingCartViewController *svc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Payment"];
    NSLog(@"All price %f", self->allPrice);
    
    if(self->allPrice == 0){
        [self genericError:@"Shopping cart is empty!"];
    }else{
        [self.navigationController pushViewController:svc animated:YES];
    }
    
//    [paymentBtn setTitle:[NSString stringWithFormat:@"Pay $%.2f", self->allPrice] forState:UIControlStateNormal];
    
}

- (IBAction)payBtn:(id)sender {
    
    FIRCollectionReference *purchase = [[[db collectionWithPath:@"Users"] documentWithPath:uid] collectionWithPath:@"Orders"];
    
    // Get current date
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy HH:mm:ss"];
    NSString *currentDate;
    currentDate = [NSString stringWithFormat:  @"%@ GMT", [dateFormat stringFromDate:[NSDate date]]];
    
    NSLog(@"This is order list: %@", orderList);
    [purchase addDocumentWithData:@{
        @"details": orderList,
        @"totalPrice": @(totalPrice),
        @"orderDate": currentDate
    }completion:^(NSError * _Nullable error) {
        if( error != nil ){
            
        }else{
            
            UIViewController *uvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Homepage"];
            [self.navigationController pushViewController:uvc animated:YES];
            
            [self purchased];
            
            // Delete document 1 by 1
            [self->cartColRef getDocumentsWithCompletion:^(FIRQuerySnapshot *snapshot, NSError * _Nullable error) {
                
                if(snapshot == nil){
                    [self genericError:[NSString stringWithFormat:@"Error fetching document: %@", error]];
                }else{
                    for (FIRDocumentSnapshot *document in snapshot.documents){
                        [[self->cartColRef documentWithPath:document.documentID] deleteDocumentWithCompletion:^(NSError * _Nullable error) {
                            if( error != nil) {
                                [self genericError:[NSString stringWithFormat:@"%@", error]];
                            }else{
                                
                            }}
                         ];
                    }
                }
            }];
        }
    }];
    
}
@end
