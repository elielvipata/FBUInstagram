//
//  PostCollectionCell.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/18/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
-(void)setPost:(Post *)post;
@end

NS_ASSUME_NONNULL_END
