//
//  PostCell.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@protocol PostCellDelegate;

@interface PostCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *postCaption;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameTop;
@property (weak, nonatomic) IBOutlet UILabel *timeStamp;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UILabel *likes;
@property (weak, nonatomic) IBOutlet UILabel *usernameBottom;
@property (strong, nonatomic) Post * post;
@property (weak, nonatomic) NSString * postID;
@property (nonatomic, weak) id<PostCellDelegate> delegate;
@property (strong, nonatomic) PFUser * user;


- (void) didTapUserProfile:(UITapGestureRecognizer *)sender;

-(void)setPost:(Post *)post;

@end

@protocol PostCellDelegate
// TODO: Add required methods the delegate needs to implement
- (void)postCell:(PostCell *) postCell didTap: (PFUser *)user;
@end

NS_ASSUME_NONNULL_END
