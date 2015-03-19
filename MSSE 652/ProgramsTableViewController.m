//
//  ProgramsTableViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/9/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//
// AFNetworking: http://www.raywenderlich.com/59255/afnetworking-2-0-tutorial

#import "ProgramsTableViewController.h"
#import "AFNetworking.h"

@interface ProgramsTableViewController ()

@end

@implementation ProgramsTableViewController

NSMutableArray *programArray = nil;
NSMutableData *_responseData = nil;
NSXMLParser *xmlParser = nil;
NSMutableDictionary *item = nil;
NSString *element = nil;
NSMutableString *className = nil;
NSMutableString *classId = nil;

/**
 *  viewDidLoad method
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    programArray = [[NSMutableArray alloc] init];
    NSURL *url =[NSURL URLWithString: @"http://regisscis.net/Regis2/webresources/regis2.program"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
    
    [operation
        setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *requestOperation, id responseObject) {
            
            NSLog(@"Successful Reponse, start processing!");
            
            // create a new parser and set this controller to be the delegate called after parsing completes
            NSXMLParser *parser = (NSXMLParser *)responseObject;
            [parser setShouldProcessNamespaces:YES];
            [parser setDelegate:self];
            [parser parse];
        
        }
        failure:^(AFHTTPRequestOperation *requestOperation, NSError *error) {
            NSLog(@"Request Failed! %@", error);
        }
     ];
    
    // run the operation to load from the URL
    [operation start];
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
    return [programArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = [[programArray objectAtIndex:indexPath.row] objectForKey: @"name"];
    return cell;
}


/* Implement the NSXMLParser Delegate Methods */

/**
 * Called when a new xml element is encountered
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"program"]) {
        
        item        = [[NSMutableDictionary alloc] init];
        className   = [[NSMutableString alloc] init];
        classId     = [[NSMutableString alloc] init];
        
    }
    
}

/**
 * Called for every character encountered within an XML tag
 *
 */
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"name"]) {
        [className appendString:string];
    } else if ([element isEqualToString:@"id"]) {
        [classId appendString:string];
    }
    
}

/**
 * Called when the end tag of an XML element is reached
 *
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"program"]) {
        
        [item setObject:className forKey:@"name"];
        [item setObject:classId forKey:@"id"];
        
        [programArray addObject:[item copy]];
        
    }
    
}

/**
 * Called when the parser reaches the end of the document
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.tableView reloadData];
    NSLog(@"Reloading tableView Data");
}

@end
