//
//  UserProfileViewController.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/21/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageFeeds;
@property (weak, nonatomic) IBOutlet UICollectionView *posts;
@property (strong, nonatomic) PFUser * user;

@end

NS_ASSUME_NONNULL_END
