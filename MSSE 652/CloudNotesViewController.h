//
//  CloudNotesViewController.h
//  MSSE 652
//
//  Created by Jason Weber on 4/11/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CloudNotesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *notesTextArea;
@property NSMutableArray *notes;

- (IBAction)saveBtn:(id)sender;
- (IBAction)refreshBtn:(id)sender;


@end
