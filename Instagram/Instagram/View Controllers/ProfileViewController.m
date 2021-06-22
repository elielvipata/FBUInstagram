//
//  ProfileViewController.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/18/21.
//

#import "ProfileViewController.h"
#import "Parse/Parse.h"
#import "PostCollectionCell.h"
#import "UIImageView+AFNetworking.h"


@interface ProfileViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (strong, nonatomic) NSArray * userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.posts.delegate = self;
    self.posts.dataSource = self;
    [self fetchUserData];
    [self getPostData];
    
    UICollectionViewFlowLayout * layout = (UICollectionViewFlowLayout*)self.posts.collectionViewLayout;
    CGFloat posterPerLine = 3;
    CGFloat width = self.posts.frame.size.width/3;
    CGFloat height = width;
    layout.itemSize = CGSizeMake(width, height);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)fetchUserData{
    PFUser * user= PFUser.currentUser;
    [user fetchIfNeeded];
    self.usernameButton.title = user[@"username"];
    self.fullNameLabel.text = user[@"fullname"];
    self.bioLabel.text = user[@"bio"];
    
    self.profileImage.layer.cornerRadius = 55.0;
    self.profileImage.clipsToBounds = YES;
    PFFileObject * image = user[@"profile_image"];
    NSURL * urlString = [NSURL URLWithString:image.url];
    [self.profileImage setImageWithURL:urlString];
}

-(void)getPostData{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];

       // fetch data asynchronously
       
       [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
           if (objects != nil) {
               self.userPosts = objects;
               for(Post * post in self.userPosts){
                   NSLog(@"%@", post);
               }
           } else {
               NSLog(@"%@", error.localizedDescription);
           }
           [self.posts reloadData];
       }];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PostCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    Post * post = self.userPosts[indexPath.row];
    PFFileObject * image = post[@"image"];
    NSURL * urlString = [NSURL URLWithString:image.url];
    [cell.postImage setImageWithURL:urlString];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.userPosts.count;
}


- (IBAction)onEditButton:(id)sender {
}
- (IBAction)onCameraButton:(id)sender {
}

- (void)viewWillAppear:(BOOL)animated{
    [self fetchUserData];
    [self getPostData];
}

-(void)viewDidAppear:(BOOL)animated{
    [self fetchUserData];
    [self getPostData];
}
- (IBAction)onLogoutButton:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        // PFUser.current() will now be nil
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
}

@end
