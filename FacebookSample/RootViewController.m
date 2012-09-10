//
//  RootViewController.m
//  FacebookSample
//
//  Created by Vladmir on 10/09/2012.
//  Copyright (c) 2012 Vladmir. All rights reserved.
//

#import "RootViewController.h"
#import "DEFacebookComposeViewController.h"


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
