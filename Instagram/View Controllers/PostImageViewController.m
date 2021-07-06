//
//  PostImageViewController.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import "PostImageViewController.h"
#import "Post.h"

@interface PostImageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImage * imageToPost;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UIImageView *previewImage;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation PostImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shareButton.enabled = NO;
    self.previewImage.alpha = 0;
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
- (IBAction)onCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onSelectImage:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (IBAction)uploadImage:(id)sender {
    
    [self.activityIndicator startAnimating];
    [Post postUserImage:self.imageToPost withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error){
        if(succeeded){
            NSLog(@"Post uploaded");
            [self.activityIndicator stopAnimating];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            NSString * errorString = [error localizedDescription];
            NSLog(@"%@", errorString);
        }
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    self.imageToPost = info[UIImagePickerControllerEditedImage];
    self.shareButton.enabled = YES;
    self.previewImage.alpha = 1;
    self.previewImage.image = self.imageToPost;
//    self.cameraView.alpha = 0;
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)onCaptureButton:(id)sender {
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];

    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
}

- (void)viewDidAppear:(BOOL)animated{
    self.captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!backCamera) {
        NSLog(@"Unable to access back camera!");
        return;
    }
    
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera
                                                                        error:&error];
    if (!error) {
        //Step 9
        self.stillImageOutput = [AVCapturePhotoOutput new];

        if ([self.captureSession canAddInput:input] && [self.captureSession canAddOutput:self.stillImageOutput]) {
            
            [self.captureSession addInput:input];
            [self.captureSession addOutput:self.stillImageOutput];
            [self setupLivePreview];
        }
    }
    else {
        NSLog(@"Error Unable to initialize back camera: %@", error.localizedDescription);
    }
}
    



- (void)setupLivePreview {
    
    self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    if (self.videoPreviewLayer) {
        
        self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
        self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
        [self.cameraView.layer addSublayer:self.videoPreviewLayer];
        
        //Step12
        dispatch_queue_t globalQueue =  dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
        dispatch_async(globalQueue, ^{
            [self.captureSession startRunning];
            //Step 13
            dispatch_async(dispatch_get_main_queue(), ^{
                self.videoPreviewLayer.frame = self.cameraView.bounds;
            });
        });
    }
}


- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    
    NSData *imageData = photo.fileDataRepresentation;
    if (imageData) {
        UIImage *image = [UIImage imageWithData:imageData];
        // Add the image to captureImageView here...
        self.previewImage.image = image;
        self.previewImage.alpha = 1;
//        self.cameraView.alpha = 0;
        self.imageToPost = image;
        self.shareButton.enabled = YES;
    }
}
    

@end
