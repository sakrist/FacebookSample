//
//  RootViewController.m
//  FacebookSample
//
//  Created by Vladmir on 10/09/2012.
//  Copyright (c) 2012 www.develoers-life.com. All rights reserved.
//

#import "RootViewController.h"
#import "DEFacebookComposeViewController.h"
#import <FacebookSDK/FacebookSDK.h>

#import <Social/Social.h>

@interface RootViewController ()
@end

@implementation RootViewController



- (void)dealloc
{
    [_pageViewController release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}

- (IBAction) shareViaFacebook: (id)sender {
    
    DEFacebookComposeViewController *facebookViewComposer = [[DEFacebookComposeViewController alloc] init];
    
    // If you want to use the Facebook app with multiple iOS apps you can set an URL scheme suffix
//    facebookViewComposer.urlSchemeSuffix = @"facebooksample";
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [facebookViewComposer setInitialText:@"Look on this"];
    
    // optional
    [facebookViewComposer addImage:[UIImage imageNamed:@"1.jpg"]];
    // and/or
    // optional
//    [facebookViewComposer addURL:[NSURL URLWithString:@"http://applications.3d4medical.com/heart_pro.php"]];
    
    [facebookViewComposer setCompletionHandler:^(DEFacebookComposeViewControllerResult result) {
        switch (result) {
            case DEFacebookComposeViewControllerResultCancelled:
                NSLog(@"Facebook Result: Cancelled");
                break;
            case DEFacebookComposeViewControllerResultDone:
                NSLog(@"Facebook Result: Sent");
                break;
        }
        
        [self dismissModalViewControllerAnimated:YES];
    }];
    
    [self presentViewController:facebookViewComposer animated:YES completion:^{ }];
    
    [facebookViewComposer release];

}



- (IBAction)likesCheck:(id)sender {
    

    FBRequestConnection *newConnection = [[[FBRequestConnection alloc] init] autorelease];
    FBRequest *request = [[FBRequest alloc] initWithSession:FBSession.activeSession
                                                  graphPath:@"me/likes"
                                                 parameters:[NSMutableDictionary dictionary]
                                                 HTTPMethod:@"GET"];
    
    [newConnection addRequest:request completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (error)
        {
            NSLog(@"error %@", result);
        } else {
            BOOL liked = NO;
            NSLog(@"result %@", result);
            if ([result isKindOfClass:[NSDictionary class]]){
                NSArray *likes = [result objectForKey:@"data"];

                for (NSDictionary *like in likes) {
                    if ([[like objectForKey:@"id"] isEqualToString:@"__page_id__"]) {
                        NSLog(@"like");
                        liked = YES;
                        break;
                    }
                }
            }
            
            if (!liked) {
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://page/__page_id__"]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://page/__page_id__"]];
                } else {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.facebook.com/pages/3D4Medicalcom-LLC/__page_id__"]];
                }
            }
        };
    }];
    
    [newConnection start];
    
    [request release];
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPageViewController delegate methods

/*
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    
}
 */

@end
