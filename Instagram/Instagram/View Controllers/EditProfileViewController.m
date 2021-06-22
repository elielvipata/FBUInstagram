//
//  EditProfileViewController.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/18/21.
//

#import "EditProfileViewController.h"
#import "Parse/Parse.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"

@interface EditProfileViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImage *imageToPost;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFUser * user = PFUser.currentUser;
    [user fetchIfNeeded];
    self.usernameField.text = user[@"username"];
    self.fullNameField.text = user[@"fullname"];
    self.bioField.text = user[@"bio"];
    if(user[@"pronouns"] != nil){
        self.pronounsField.text = user[@"pronouns"];
    }
    
    if(user[@"website"] != nil){
        self.websiteField.text =  user[@"website"];
    }
    
    if(user[@"bioField"] != nil){
        self.bioField.text = user[@"bioField"];
    }
    
    self.profileImage.layer.cornerRadius = 66.25;
    self.profileImage.clipsToBounds = YES;
    PFFileObject * image = user[@"profile_image"];
    NSURL * urlString = [NSURL URLWithString:image.url];
    [self.profileImage setImageWithURL:urlString];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:TRUE completion:nil];
}
- (IBAction)onDoneButton:(id)sender {
    
    PFUser * user = PFUser.currentUser;
    [user fetchIfNeeded];
    user[@"fullname"] = self.fullNameField.text;
    user[@"pronouns"] = self.pronounsField.text;
    user[@"username"] = self.usernameField.text;
    user[@"website"] = self.websiteField.text;
    user[@"bio"] = self.bioField.text;
    if(self.imageToPost != nil){
        NSData * imageData = UIImagePNGRepresentation(self.imageToPost);
        PFObject * image = [PFFileObject fileObjectWithName:@"image.png" data:imageData];
        user[@"profile_image"] = image;
    }
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
        if(succeeded){
            NSLog(@"Update Successfull");
            [self dismissViewControllerAnimated:TRUE completion:nil];
        }else{
            NSLog([error localizedDescription]);
        }
    }];
    
    
}
- (IBAction)onChangeButton:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    self.imageToPost = info[UIImagePickerControllerEditedImage];
    


    // Do something with the images (based on your use case)
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    PFUser * user = PFUser.currentUser;
    [user fetchIfNeeded];
    self.usernameField.text = user[@"username"];
    self.fullNameField.text = user[@"fullname"];
    self.bioField.text = user[@"bio"];
    if(user[@"pronouns"] != nil){
        self.pronounsField.text = user[@"pronouns"];
    }
    
    if(user[@"website"] != nil){
        self.websiteField.text =  user[@"website"];
    }
    
    if(user[@"bioField"] != nil){
        self.bioField.text = user[@"bioField"];
    }
    
    self.profileImage.layer.cornerRadius = 66.25;
    self.profileImage.clipsToBounds = YES;
    PFFileObject * image = user[@"profile_image"];
    NSURL * urlString = [NSURL URLWithString:image.url];
    [self.profileImage setImageWithURL:urlString];
}

- (void)viewDidAppear:(BOOL)animated{
    PFUser * user = PFUser.currentUser;
    [user fetchIfNeeded];
    self.usernameField.text = user[@"username"];
    self.fullNameField.text = user[@"fullname"];
    self.bioField.text = user[@"bio"];
    if(user[@"pronouns"] != nil){
        self.pronounsField.text = user[@"pronouns"];
    }
    
    if(user[@"website"] != nil){
        self.websiteField.text =  user[@"website"];
    }
    
    if(user[@"bioField"] != nil){
        self.bioField.text = user[@"bioField"];
    }
    
    self.profileImage.layer.cornerRadius = 66.25;
    self.profileImage.clipsToBounds = YES;
    PFFileObject * image = user[@"profile_image"];
    NSURL * urlString = [NSURL URLWithString:image.url];
    [self.profileImage setImageWithURL:urlString];
}

@end
