//
//  ViewController.m
//  testChat
//
//  Created by Vipata Kilembo on 6/17/21.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onLoginButton:(id)sender {
    
    NSString *username = self.usernameField.text;
      NSString *password = self.passwordField.text;
      
      [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
          if (error != nil) {
              NSLog(@"User log in failed: %@", error.localizedDescription);
          } else {
              NSLog(@"User logged in successfully");
              
              // display view controller that needs to shown after successful login
          }
      }];
    
}
- (IBAction)onSignup:(id)sender {
    
    if([self.usernameField.text length] == 0 || [self.passwordField.text length] == 0){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                                   message:@"Username or Password field cannot be empty"
                                                                            preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                                 // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
        
        
        
        return;
        
        
    }
    
    PFUser *newUser = [PFUser user];
        
        // set user properties
        newUser.username = self.usernameField.text;
        newUser.password = self.passwordField.text;
        
        // call sign up function on the object
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
            if (error != nil) {
                NSLog(@"Error: %@", error.localizedDescription);
                
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                                               message:error.localizedDescription
                                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
                    
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                       style:UIAlertActionStyleDefault
                                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                                             // handle response here.
                                                                     }];
                    // add the OK action to the alert controller
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:^{
                        // optional code for what happens after the alert controller has finished presenting
                    }];
                
                
            } else {
                NSLog(@"User registered successfully");
                [self performSegueWithIdentifier:@"loginSegue" sender:self];
                // manually segue to logged in view
            }
        }];
    
}

@end
