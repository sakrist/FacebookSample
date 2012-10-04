This project based on https://github.com/doubleencore/DETweetComposeViewController

Facebook connection based on SDK 3.0.x (last at 2 september 2012)


What is it?
DEFacebookComposeViewController is an iOS 4 compatible. 
Looks like as the Facebook Sheet in iOS 6.


How to use

1. download and setup Facebook sdk https://developers.facebook.com/ios/

2. register your app on http://developers.facebook.com

3. replace on your app id in plist file. FacebookAppID and in CFBundleURLTypes

4. \#import "DEFacebookComposeViewController.h"

5. example of usage
```
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
```


6. add this code to your main class and you should be sure if app is entered to this method
```
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {

    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}
```




Post on my blog http://www.developers-life.com/facebook-compose-view.html
Welcome for any questions

If you liked it, you can support me:

<a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=B4VMLFZ986FNW">
<img src="https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif" border="0" name="submit" alt="PayPal - The safer, easier way to pay online!" />
</a>
