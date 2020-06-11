//
//  MyProfileViewController.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 28/1/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController ()

@end


@implementation MyProfileViewController
@synthesize emailTextField, addressText, fullNametextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *uid;
    NSString *email;
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user){
        uid = user.uid;
        email = user.email;
    }
    
    FIRFirestore *db = FIRFirestore.firestore;
    FIRDocumentReference *userDocRef = [[db collectionWithPath:@"Users"] documentWithPath:uid];
    
    [userDocRef getDocumentWithCompletion:^(FIRDocumentSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (snapshot.exists){
            self->emailTextField.text = snapshot.data[@"email"];
            self->addressText.text = snapshot.data[@"deliveryAddress"];
            self->fullNametextField.text = snapshot.data[@"fullName"];
        }else{
            NSLog(@"Can't get doc %@", error);
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)emailTxtField:(id)sender {
}
@end
