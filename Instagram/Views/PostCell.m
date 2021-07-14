//
//  PostCell.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import "PostCell.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "DateTools.h"
#import "UIImageView+AFNetworking.h"



@implementation PostCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImage addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImage setUserInteractionEnabled:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPost:(Post *)post{
    self.postCaption.text = post[@"caption"];
    NSNumber* value = post[@"likeCount"];
//    self.likes.text = post[@"likeCount"];
    self.likes.text = [[value stringValue] stringByAppendingString:@" likes"];
    self.postID = post.objectId;

    PFUser * user = post[@"author"];
    self.user = user;
    self.usernameTop.text = user.username;
    self.usernameBottom.text = user.username;
    
    self.profileImage.layer.cornerRadius = 13.0;
    self.profileImage.clipsToBounds = YES;
    PFFileObject * profileImage = user[@"profile_image"];
    NSURL * imageURL = [NSURL URLWithString:profileImage.url];
    [self.profileImage setImageWithURL:imageURL];
    
    NSString *dateString = post[@"dateStamp"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:dateString];
    self.timeStamp.text = date.timeAgoSinceNow;
    PFFileObject * image = post[@"image"];
    NSURL * urlString = [NSURL URLWithString:image.url];
    [self.postImage setImageWithURL:urlString];
    
    
    
    
    
    if(post[@"userLikes"] != nil){
        NSMutableArray * userLikes = post[@"userLikes"];
        BOOL found = NO;
        for(PFUser * current in userLikes){
            if([current.objectId isEqualToString: PFUser.currentUser.objectId]){
                [self.likeButton setImage:[UIImage imageNamed:@"like-button-red"] forState:UIControlStateNormal];
                self.post.isLiked = YES;
                found = YES;
                break;
            }
        }
        
        if(found == NO){
            [self.likeButton setImage:[UIImage imageNamed:@"like-button"] forState:UIControlStateNormal];
            self.post.isLiked = NO;
        }
    }
}


- (IBAction)onLikeButton:(id)sender {
    NSNumber * number;
    if(self.post.isLiked == NO){
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//        [query whereKey:@"objectid" equalTo:self.postID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
            for(Post * post in posts){
                if([post.objectId isEqualToString:self.postID]){
                    NSMutableArray *currentUserLikes = post[@"userLikes"];
                    [currentUserLikes addObject:PFUser.currentUser];
                    post[@"userLikes"] = currentUserLikes;
                    
                    
                    NSNumber* count = post[@"likeCount"];
                    int value = [count intValue];
                    value +=1;
                    count = [NSNumber numberWithInt:value];
                    post[@"likeCount"] = count;
                    [self.likeButton setImage:[UIImage imageNamed:@"like-button-red"] forState:UIControlStateNormal];
                    self.likes.text = [[count stringValue] stringByAppendingString:@" likes"];
                    [post saveInBackground];
                }
            }
        }];

    }else{
        [self.likeButton setImage:[UIImage imageNamed:@"like-button"] forState:UIControlStateNormal];
        PFQuery *query = [PFQuery queryWithClassName:@"Post"];
//        [query whereKey:@"objectid" equalTo:self.postID];
        [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
            for(Post * post in posts){
                if([post.objectId isEqualToString:self.postID]){
                    NSMutableArray *currentUserLikes = post[@"userLikes"];
                    [currentUserLikes removeObject:PFUser.currentUser];
                    post[@"userLikes"] = currentUserLikes;
                    
                    
                    NSNumber* count = post[@"likeCount"];
                    int value = [count intValue];
                    value +=-1;
                    count = [NSNumber numberWithInt:value];
                    post[@"likeCount"] = count;
                    [self.likeButton setImage:[UIImage imageNamed:@"like-button"] forState:UIControlStateNormal];
                    self.likes.text = [[count stringValue] stringByAppendingString:@" likes"];
                    [post saveInBackground];
                }
            }
        }];
    }
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    //TODO: Call method delegate
    [self.delegate postCell:self didTap:self.user];

}



@end
