//
//  AppDelegate.m
//  Instagram
//
//  Created by Vipata Kilembo on 6/16/21.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
            ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {

                configuration.applicationId = @"xjnHFD17ZUHIK3a46rh0Bs3VVHYra38UPXdheoEi"; // <- UPDATE
                configuration.clientKey = @"tbrgC8skubOFByXBrZKgjy5H4S1MtMvh5LeWBVp3"; // <- UPDATE
                configuration.server = @"https://parseapi.back4app.com";
            }];

            [Parse initializeWithConfiguration:config];
    
    if (PFUser.currentUser) {
        NSLog(@"User exists");
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController * home =[storyboard instantiateViewControllerWithIdentifier:@"home"];
        [self.window setRootViewController:home];
        [self.window makeKeyAndVisible];
      }

    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
