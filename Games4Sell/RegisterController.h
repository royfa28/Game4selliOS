//
//  RegisterController.h
//  Games4Sell
//
//  Created by Roy felix Adekie on 27/1/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface RegisterController : UIViewController

@property (nonatomic) FIRDatabaseReference *ref;
@property FIRAuth *firAuth;
//@property (nonatomic, readwrite) FIRFirestore *db;

@property (weak, nonatomic) IBOutlet UITextField *loginEmailTxt;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTxt;

@property (weak, nonatomic) IBOutlet UITextField *registerEmailTxt;
@property (weak, nonatomic) IBOutlet UITextField *registerPasswordTxt;
@property (weak, nonatomic) IBOutlet UITextField *registerRepeatPasswordText;

- (IBAction)login:(id)sender;
- (IBAction)registration:(id)sender;


@end

NS_ASSUME_NONNULL_END
