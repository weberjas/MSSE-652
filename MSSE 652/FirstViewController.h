//
//  FirstViewController.h
//  MSSE 652
//
//  Created by Jason Weber on 3/2/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *chatUserText;


- (IBAction)joinBtn:(id)sender;

@end
