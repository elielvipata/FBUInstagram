//
//  ViewController.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import "ViewController.h"
#import "Parse/Parse.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view


}

- (IBAction)onLoginButton:(id)sender {
    [self loginUser];

}


- (IBAction)onSignupButton:(id)sender {
    
    [self registerUser];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
            // display view controller that needs to shown after successful login
        }
    }];
}


- (void)registerUser {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated{
    PFUser * user = [PFUser currentUser];
    if(user != nil){
        NSLog(@"User Found");
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
    }
}

@end
