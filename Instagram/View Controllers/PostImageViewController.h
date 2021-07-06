//
//  PostImageViewController.h
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PostImageViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *captionField;
@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIButton *shutterButton;

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

NS_ASSUME_NONNULL_END
