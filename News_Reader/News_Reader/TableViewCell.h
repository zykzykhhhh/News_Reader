//
//  TableViewCell.h
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextView *descriptions;

@end
