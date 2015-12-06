//
//  MainTableViewController.h
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "News.h"
#import "WebViewController.h"

@interface MainTableViewController : UITableViewController<UIAlertViewDelegate>
@property (strong, nonatomic) NSMutableArray* newsList;


-(void)getNews;

@end
