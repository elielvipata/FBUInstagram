//
//  ProfileViewController.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/18/21.
//

#import "ViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProfileViewController : ViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *imageFeeds;
@property (weak, nonatomic) IBOutlet UICollectionView *posts;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *usernameButton;

@end

NS_ASSUME_NONNULL_END
