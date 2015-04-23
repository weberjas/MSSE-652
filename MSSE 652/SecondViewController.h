//
//  SecondViewController.h
//  MSSE 652
//
//  Created by Jason Weber on 3/2/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SocketSvc.h"

@interface SecondViewController : UIViewController 

- (IBAction)sendPing:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *chatMessageText;

@property (weak, nonatomic) IBOutlet UITextView *chatMessages;

@property (weak, nonatomic) NSString *userName;

- (IBAction)sendMessageBtn:(id)sender;


@end
