//
//  HomeViewController.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import "HomeViewController.h"
#import "PostCell.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "CommentsViewController.h"
#import "UserProfileViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,PostCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *posts;
@property (strong,nonatomic)  UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;



@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(getPostStart) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = self.refreshControl;
    [self.activityIndicator startAnimating];
    
    [self getPosts:20];
    
    [self.activityIndicator stopAnimating];
    
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"commentSegue"]){
        UITableViewCell * cell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        Post * post = self.posts[indexPath.row];
        
        CommentsViewController * commentsViewController = [segue destinationViewController];
        commentsViewController.post = post;
    }
    
    if([segue.identifier isEqualToString:@"userProfileSegue"]){
        UserProfileViewController * userProfileViewController = [segue destinationViewController];
        userProfileViewController.user = sender;
    }
}


-(void)getPosts:(int) limit{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = limit;
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

-(void)getPostStart{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    [query orderByDescending:@"createdAt"];

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            // do something with the array of object returned by the call
            self.posts = posts;
            [self.tableView reloadData];
            [self.refreshControl endRefreshing];

        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostCell * cell = (PostCell *)[tableView dequeueReusableCellWithIdentifier:@"PostCell" forIndexPath:indexPath];
    Post * post = self.posts[indexPath.row];
    
    cell.post = post;
    [cell setPost:post];
    cell.delegate = self;

    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.posts.count;
}
- (IBAction)onLogout:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        
        NSLog(@"User logged out");
        [self dismissViewControllerAnimated:YES completion:nil];

        // PFUser.current() will now be nil
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row + 1 == [self.posts count]){
        [self getPosts:[self.posts count] + 20];
        [self.tableView reloadData];
    }
}

- (void)postCell:(PostCell *)postCell didTap:(PFUser *)user{
    [self performSegueWithIdentifier:@"userProfileSegue" sender:user];
}

@end
