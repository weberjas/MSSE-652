//
//  SecondViewController.h
//  MSSE 652
//
//  Created by Jason Weber on 3/2/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketSvc.h"

@interface SecondViewController : UIViewController <NSStreamDelegate>
@property (weak, nonatomic) IBOutlet UITextField *chatMessageText;
@property (weak, nonatomic) IBOutlet UITextView *chatMessages;
- (IBAction)sendMessageBtn:(id)sender;

@property SocketSvc *socketSvc;

@end
