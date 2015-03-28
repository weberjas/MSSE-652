//
//  ArticleViewController.h
//  MSSE 652
//
//  Created by Jason Weber on 3/27/15.
//  Copyright (c) 2015 msse652. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"

@interface ArticleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *publishDateField;
@property (weak, nonatomic) IBOutlet UITextField *sourceField;
@property (weak, nonatomic) IBOutlet UITextField *sourceUrlField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *urlField;
@property (weak, nonatomic) IBOutlet UITextView *summaryText;


@property Article *article;
@end
