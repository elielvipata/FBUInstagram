//
//  CommentsViewController.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/19/21.
//

#import "CommentsViewController.h"
#import "CommentCell.h"
#import "Parse/Parse.h"

@interface CommentsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *commentArray;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.commentArray = [NSMutableArray new];
    [self fetchComments];
    
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)fetchComments{
    PFQuery *query = [PFQuery queryWithClassName:@"Comments"];
       [query includeKey:@"user"];
       query.limit = 20;
       [query orderByDescending:@"createdAt"];

       // fetch data asynchronously
       
       [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
           if (objects != nil) {
               self.commentArray = objects;
               [self filterComments];
               // do something with the array of object returned by the call
           } else {
               NSLog(@"%@", error.localizedDescription);
           }
           [self.tableView reloadData];
       }];
}

-(void)filterComments{
    PFQuery *query = [PFQuery queryWithClassName:@"Comments"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *comments, NSError *error) {
        [self.post fetchIfNeeded];
        for(PFObject * comment in comments){
            PFObject * current = comment[@"post"];
            [current fetchIfNeeded];
            if(![self.post.postID isEqualToString: current.objectId]){
                [self.commentArray removeObject:comment];
            }
        }
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
    NSDictionary *comment = self.commentArray[indexPath.row];
    cell.commentText.text = comment[@"text"];
    PFUser *user = comment[@"user"];
    [user fetchIfNeeded];
    NSLog(@"%@", user.username);
    if (user != nil) {
        // User found! update username label with username
        cell.username.text = user.username;
    } else {
        // No user found, set default username
        cell.username.text = @"🤖";
    }
    return cell;

}

- (IBAction)onPostButton:(id)sender {
    PFObject *comment = [PFObject objectWithClassName:@"Comments"];
    comment[@"text"] = self.messageTextField.text;
    comment[@"user"] = PFUser.currentUser;
    comment[@"post"] = self.post;
    [comment saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The comment was saved!");
            self.messageTextField.text = @"";
            [self.commentArray insertObject:comment atIndex:0];
            [self.tableView reloadData];
        } else {
            NSLog(@"Problem saving comment: %@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}

@end
