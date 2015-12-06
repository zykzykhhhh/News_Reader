//
//  WebViewController.m
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.loadingNotice = [[UIAlertView alloc] initWithTitle:@"Loading..."
                                               message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [indicator startAnimating];
    [self.loadingNotice setValue:indicator forKey:@"accessoryView"];
    self.webView.delegate = self;
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:_webLink];
    [self.webView loadRequest:urlRequest];
    [self.loadingNotice show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithLink:(NSURL*) webLink{
    if(self = [super init])
    {
        self.webLink = webLink;
    }
    return self;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"fail loading%@", [error description]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"check your network connection" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:nil];
    [alert show];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"didFinish: %@; stillLoading: %@", [[webView request]URL],
          (webView.loading?@"YES":@"NO"));
    if(webView.loading)
    {
        
    }else{
        [self.loadingNotice dismissWithClickedButtonIndex:0 animated:TRUE];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.loadingNotice dismissWithClickedButtonIndex:0 animated:TRUE];
    [self.navigationController popViewControllerAnimated:YES];
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
