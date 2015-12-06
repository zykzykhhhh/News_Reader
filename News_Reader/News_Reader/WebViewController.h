//
//  WebViewController.h
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (strong,nonatomic) NSURL * webLink;
@property (strong,nonatomic) UIAlertView *loadingNotice;
-(id)initWithLink:(NSURL*) webLink;
@end
