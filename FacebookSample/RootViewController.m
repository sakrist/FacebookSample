//
//  RootViewController.m
//  FacebookSample
//
//  Created by Vladmir on 10/09/2012.
//  Copyright (c) 2012 Vladmir. All rights reserved.
//

#import "RootViewController.h"
#import "DEFacebookComposeViewController.h"
#import <FacebookSDK/FacebookSDK.h>

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
    DEFacebookComposeViewControllerCompletionHandler completionHandler = ^(DEFacebookComposeViewControllerResult result) {
        switch (result) {
            case DEFacebookComposeViewControllerResultCancelled:
                NSLog(@"Facebook Result: Cancelled");
                break;
            case DEFacebookComposeViewControllerResultDone:
                NSLog(@"Facebook Result: Sent");
                break;
        }
        
        [self dismissModalViewControllerAnimated:YES];
    };
    
    DEFacebookComposeViewController *facebookViewComposer = [[DEFacebookComposeViewController alloc] init];
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    [facebookViewComposer setInitialText:@"Look on this"];
    [facebookViewComposer addImage:[UIImage imageNamed:@"1.jpg"]];
    facebookViewComposer.completionHandler = completionHandler;
    [self presentViewController:facebookViewComposer animated:YES completion:^{ }];

}



- (IBAction)likesCheck:(id)sender {
    

    FBRequestConnection *newConnection = [[FBRequestConnection alloc] init];
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
