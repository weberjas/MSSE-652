//
//  SocialViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 4/1/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "SocialViewController.h"
#import <Social/Social.h>

@interface SocialViewController ()

@end

@implementation SocialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)updateFacebookBtn:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *view = [SLComposeViewController
                                         composeViewControllerForServiceType:SLServiceTypeFacebook]; [self presentViewController:view animated:YES completion:nil];
    } else {
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Facebook Error"
                                                           message:@"Could not connect to Twitter Account! Please ensure you're logged in!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }
}

- (IBAction)updateTwitterBtn:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *view = [SLComposeViewController
                                         composeViewControllerForServiceType:SLServiceTypeTwitter]; [self presentViewController:view animated:YES completion:nil];
    } else {
        UIAlertView *theAlert = [[UIAlertView alloc] initWithTitle:@"Twitter Error"
                                                           message:@"Could not connect to Twitter Account! Please ensure you're logged in!"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:nil];
        [theAlert show];
    }
}
@end
