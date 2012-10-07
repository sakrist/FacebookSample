//
//  RootViewController.h
//  FacebookSample
//
//  Created by Vladmir on 10/09/2012.
//  Copyright (c) 2012 www.develoers-life.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (IBAction) shareViaFacebook: (id)sender;

@end
