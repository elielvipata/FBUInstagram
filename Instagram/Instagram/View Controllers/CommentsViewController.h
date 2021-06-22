//
//  CommentsViewController.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/19/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
