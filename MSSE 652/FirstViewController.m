//
//  FirstViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/2/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "SocketSvc.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

SocketSvc *socketSvc = nil;

- (IBAction)joinBtn:(id)sender {
    
    socketSvc = [[SocketSvc alloc] init];
    
    NSString *connectString = [NSString stringWithFormat:@"iam:%@", self.chatUserText.text];
    [socketSvc connect:connectString];
    
    //[self performSegueWithIdentifier:@"FromFirstToSecond" sender:sender];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];


    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
 SecondViewController *destViewController = segue.destinationViewController;
 
 destViewController.socketSvc = socketSvc;
}


@end
