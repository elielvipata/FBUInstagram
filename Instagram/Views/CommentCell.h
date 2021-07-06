//
//  CommentCell.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/19/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *commentText;

@end

NS_ASSUME_NONNULL_END
