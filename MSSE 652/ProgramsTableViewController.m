//
//  ProgramsTableViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/9/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "ProgramsTableViewController.h"
#import "AppDelegate.h"
#import "ArticleList.h"
#import "Article.h"

@interface ProgramsTableViewController ()

@end

@implementation ProgramsTableViewController


/**
 *  viewDidLoad method
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];
    
}

/**
 *  didReceiveMemoryWarning
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/**
 *  Return the number of sections in this table. There will only ever be one.
 *
 *  @param tableView <#tableView description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

/**
 *  Return the number of rows in the table.
 *
 *  @param tableView <#tableView description#>
 *  @param section   <#section description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.articles count];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Article *article = self.articles[indexPath.row];
        [[segue destinationViewController] setDetailItem:article.summary];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    Article *article = [self.articles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = article.title;
    
    return cell;
}


#pragma mark - RESTKit

- (void)requestData {
    
    NSString *requestPath = @"/v1/categories/16/articles.json";
    
    [[RKObjectManager sharedManager]
     getObjectsAtPath:requestPath
     parameters:nil
     success: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
         //articles have been saved in core data by now
         [self fetchArticlesFromContext];
     }
     failure: ^(RKObjectRequestOperation *operation, NSError *error) {
         RKLogError(@"Load failed with error: %@", error);
     }
     ];
    
}

- (void)fetchArticlesFromContext {
    
    NSManagedObjectContext *context = [RKManagedObjectStore defaultStore].mainQueueManagedObjectContext;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"ArticleList"];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    fetchRequest.sortDescriptors = @[descriptor];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    
    ArticleList *articleList = [fetchedObjects firstObject];
    
    self.articles = [articleList.articles allObjects];
    
    [self.tableView reloadData];
    
}
@end
