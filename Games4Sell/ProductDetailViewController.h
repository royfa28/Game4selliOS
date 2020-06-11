//
//  ProductDetailViewController.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 4/2/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *gameName;
@property (weak, nonatomic) IBOutlet UILabel *gamePlatform;
@property (weak, nonatomic) IBOutlet UIImageView *gameImage;
@property (weak, nonatomic) IBOutlet UILabel *gamePrice;
- (IBAction)addToCart:(id)sender;

@property FIRDocumentSnapshot *products;
@end

NS_ASSUME_NONNULL_END
