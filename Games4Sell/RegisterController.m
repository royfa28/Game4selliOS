//
//  RegisterController.m
//  Games4Sell
//
//  Created by Roy felix Adekie on 27/1/20.
//  Copyright © 2020 Roy felix Adekie. All rights reserved.
//
#import "AppDelegate.h"
#import "RegisterController.h"

@implementation RegisterController

@synthesize loginEmailTxt, loginPasswordTxt, registerEmailTxt, registerPasswordTxt, registerRepeatPasswordText, ref, firAuth;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[FIRAuth auth] addAuthStateDidChangeListener:^(FIRAuth *auth, FIRUser *user) {
        if (user!= nil) {
            [self goToHomeScreen];
        }else{
            
        }
    }];
}


- (IBAction)registration:(id)sender {
    if([self validation]){
        [[FIRAuth auth] createUserWithEmail:registerEmailTxt.text password:registerPasswordTxt.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {

            if (error) {
                [self displayAlertView:error.localizedDescription];
                NSLog(@"Error in FIRAuth := %@",error.localizedDescription);
            }
            else{
                NSLog(@"user Id : %@", authResult.user.uid);
                [self writetoDB];
                
            }
        }];
    }
}

- (IBAction)login:(id)sender {
    if ([self validationLogin]){
        
        [[FIRAuth auth] signInWithEmail:loginEmailTxt.text password:loginPasswordTxt.text completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
            if (error) {
                [self displayAlertView:@"Please enter valid password"];
                NSLog(@"Error in FIRAuth := %@",error.localizedDescription);
            }
            else{
                self.loginEmailTxt.text = @"";
                self.loginPasswordTxt.text = @"";
                NSLog(@"user Id : %@", authResult.user.uid);
                
                [self success:@"Successfully login with Firebase."];
            }
        }];
    }
}

-(void)goToHomeScreen{
    UIViewController *uvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"Homepage"];
    [self.navigationController pushViewController:uvc animated:YES];
}

#pragma mark - All Validation methods
- (BOOL)validation{
    NSString *strEmailID = [registerEmailTxt.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    NSString *strPassword = [registerPasswordTxt.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
    NSString *strConfirmPassword = [registerRepeatPasswordText.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
    if (strEmailID.length <= 0){
        [self displayAlertView:@"Please enter email Id"];
        return NO;
    }
    else if ([self validateEmailAddress:strEmailID] == NO){
        [self displayAlertView:@"Please enter valid email Id"];
        return NO;
    }
    else if (strPassword.length <= 0){
        [self displayAlertView:@"Please enter password"];
        return NO;
    }
    else if (strConfirmPassword.length <= 0){
        [self displayAlertView:@"Please enter confirm password"];
        return NO;
    }
    else if (![strPassword isEqualToString:strConfirmPassword]){
        [self displayAlertView:@"Password and confirm password does not match"];
        return NO;
    }
    
    return YES;
}

-(BOOL)validationLogin{
    NSString *strEmailID = [loginEmailTxt.text stringByTrimmingCharactersInSet:
                            [NSCharacterSet whitespaceCharacterSet]];
    NSString *strPassword = [loginPasswordTxt.text stringByTrimmingCharactersInSet:
                             [NSCharacterSet whitespaceCharacterSet]];
    
    if (strEmailID.length <= 0){
        [self displayAlertView:@"Please enter email Id"];
        return NO;
    }
    else if (strPassword.length <= 0){
        [self displayAlertView:@"Please enter password"];
        return NO;
    }
    else if ([self validateEmailAddress:strEmailID] == NO){
        [self displayAlertView:@"Please enter valid email Id"];
        return NO;
    }
    return YES;
}

-(BOOL)validateEmailAddress:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

#pragma mark - UIAlertView  methods
-(void)displayAlertView:(NSString *)strMessage{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"My Alert"
        message:strMessage
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {}];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)success:(NSString *)strMessage{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Welcome"
        message:strMessage
        preferredStyle:UIAlertControllerStyleAlert];
     
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
        handler:^(UIAlertAction * action) {
//        [self goToHomeScreen];
    }];
     
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)writetoDB{
    
    NSString *uid;
    NSString *email;
    
    FIRUser *user = [FIRAuth auth].currentUser;
    if(user){
        uid = user.uid;
        email = user.email;
    }
    FIRFirestore *db = FIRFirestore.firestore;
    
    NSLog(@"user is %@", uid);
    [[[db collectionWithPath:@"Users"]
      documentWithPath:uid] setData:@{
      @"deliveryAddress": @"",
      @"email": email
    } completion:^(NSError * _Nullable error) {
      if (error != nil) {
        NSLog(@"Error writing document: %@", error);
      } else {
        NSLog(@"Document successfully written!");
      }
    }];
    [self success:@"Successfully signup with Firebase."];
}

@end
