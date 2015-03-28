//
//  ArticleViewController.m
//  MSSE 652
//
//  Created by Jason Weber on 3/27/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // if there is data in the article object which should have been passed by the segue..
    if (self.article) {
        self.publishDateField.text = [self.article.publish_date description];
        self.sourceField.text = self.article.source;
        self.sourceUrlField.text = self.article.source_url;
        self.summaryText.text = self.article.summary;
        self.titleField.text = self.article.title;
        self.urlField.text = self.article.url;
        
    }
    // Do any additional setup after loading the view.
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

@end
