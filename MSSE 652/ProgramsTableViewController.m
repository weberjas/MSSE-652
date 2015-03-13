//
//  ProgramsTableViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/9/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "ProgramsTableViewController.h"

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
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

/* Implement the NSURLConnectionDelegate Methods */

/**
 *  Recieved a response from the server
 *
 *  @param connection  NSURLConnection
 *  @param response    NSURLResponse
 */
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

/**
 *  Data received from the server
 *
 *  @param connection NSURLConnection
 *  @param data       NSData
 */
- (void) connection:(NSURLConnection *) connection didReceiveData:(NSData *)data {
    [_responseData appendData:data];
}

/**
 *  Response Caching
 *
 *  @param connection     NSURLConnection
 *  @param cachedResponse NSCachedURLResponse
 *
 *  @return <#return value description#>
 */
- (NSCachedURLResponse *) connection: (NSURLConnection *) connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}


/**
 *  Process data after the connection is finished loading data from the server.
 *  Using this as a template: http://www.appcoda.com/ios-programming-rss-reader-tutorial/
 *
 *  @param connection NSURLConnection
 */
- (void) connectionDidFinishLoading:(NSURLConnection *) connection {
    
    NSLog(@"Finised loading data");
    
    xmlParser = [[NSXMLParser alloc] initWithData:_responseData];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:NO];
    [xmlParser parse];
    
}

/**
 *  connection failed
 *
 *  @param connection <#connection description#>
 *  @param error      <#error description#>
 */
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Server connection failed: %@", error);
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
