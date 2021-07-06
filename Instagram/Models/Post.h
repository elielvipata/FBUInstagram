//
//  Post.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface Post : PFObject<PFSubclassing>

    @property (nonatomic, strong) NSString *postID;
    @property (nonatomic, strong) NSString *userID;
    @property (nonatomic, strong) PFUser *author;


    @property (nonatomic, strong) NSString *caption;
    @property (nonatomic, strong) PFFileObject *image;
    @property (nonatomic, strong) NSNumber *likeCount;
    @property (nonatomic, strong) NSNumber *commentCount;
    @property (nonatomic, strong) NSString * dateStamp;
    @property (nonatomic, strong) NSMutableArray * userLikes;
    @property (nonatomic) BOOL isLiked;

    + (void) postUserImage: ( UIImage * _Nullable )image withCaption: ( NSString * _Nullable )caption withCompletion: (PFBooleanResultBlock  _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
