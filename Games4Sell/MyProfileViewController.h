//
//  MyProfileViewController.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 28/1/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface MyProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *fullNametextField;
@property (weak, nonatomic) IBOutlet UITextView *addressText;

@end

NS_ASSUME_NONNULL_END
