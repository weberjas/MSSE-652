//
//  CloudNotesViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 4/11/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "CloudNotesViewController.h"

@interface CloudNotesViewController ()

@end

@implementation CloudNotesViewController

NSUbiquitousKeyValueStore *store = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    store = [NSUbiquitousKeyValueStore defaultStore];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeDidChange:) name:NSUbiquitousKeyValueStoreDidChangeExternallyNotification object:store];
    
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAddNewNote:) name:@"New Note" object:nil];
    
    self.notesTextArea.text = [store stringForKey:@"MY_NOTES"];
}

- (void) didAddNewNote: (NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *noteString = [userInfo valueForKey:@"Note"];
    
    [[NSUbiquitousKeyValueStore defaultStore] setString:noteString forKey:@"MY_NOTES"];
    
}

- (void) storeDidChange: (NSNotification *) notification {
    NSLog(@"StoreDidChange Called!");
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

- (IBAction)saveBtn:(id)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"New Note" object:self userInfo:[NSDictionary dictionaryWithObject:self.notesTextArea.text forKey:@"Note"]];
}

- (IBAction)refreshBtn:(id)sender {
    self.notesTextArea.text = @"";
    [[NSUbiquitousKeyValueStore defaultStore] synchronize];
    self.notesTextArea.text = [store stringForKey:@"MY_NOTES"];

}
@end
