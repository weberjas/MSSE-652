//
//  SecondViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/2/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

/**
 * Run when the view loads
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.socketSvc setOutputTextView:self.chatMessages];
    
    // Do any additional setup after loading the view.
}

/**
 *  Run when memory warning recieved
 */
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

- (IBAction)sendMessageBtn:(id)sender {
    
    [self.socketSvc send:[@"msg:" stringByAppendingString:self.chatMessageText.text]];
    //NSString *chatMessages = [self.chatMessages.text stringByAppendingString:[self.socketSvc retrieve]];
    
    //self.chatMessages.text = chatMessages;
}
@end
