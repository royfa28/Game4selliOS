//
//  ProductDetailViewController.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 4/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "ProductDetailViewController.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

@synthesize gameName, gamePlatform, gamePrice, gameImage;
@synthesize products;
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
//    TabbedViewController *tab;
    gameName.text = products[@"Name"];
    gamePlatform.text = [NSString stringWithFormat:@"Platform: %@", products[@"Platform"]];
    gamePrice.text = [NSString stringWithFormat:@"$ %@" , products[@"Price"]];
    
    // Get image URL
    NSString *result = products[@"photoUrl"];
    NSLog(@"%@", result);
    NSData *imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString:result]];
    
    gameImage.image = [UIImage imageWithData:imageData];
    
    NSLog(@"This from detail %@", products.data);
    
    
}

- (IBAction)addToCart:(id)sender {
    
    NSString *uid;
    NSString *gameID = products.documentID;
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user){
        uid = user.uid;
    }
    FIRDocumentReference *ref;
    FIRFirestore *db = FIRFirestore.firestore;
    
    [[[[[db collectionWithPath:@"Users"]
       documentWithPath:uid]collectionWithPath:@"shoppingCart"]
     documentWithPath:gameID] setData:@{
          @"Name": products[@"Name"],
          @"Price": products[@"Price"],
          @"Quantity": @1,
          @"photoUrl": products[@"photoUrl"]
      }completion:^(NSError * _Nullable error){
         if(error != nil){
             NSLog(@"Error adding document: %@", error);
         }else{
             [self addedTocart];
         }
     }];
}

#pragma mark - Notification
-(void)addedTocart{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
        message:@"Product has added to cart"
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
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

@end
