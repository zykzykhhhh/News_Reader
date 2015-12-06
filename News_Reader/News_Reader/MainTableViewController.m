//
//  MainTableViewController.m
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import "MainTableViewController.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.newsList = [[NSMutableArray alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getNews];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.newsList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    News* n = [self.newsList objectAtIndex:indexPath.row];
    cell.title.text = n.title;
    cell.descriptions.text = n.descriptions;
    if(![[n.imageUrl absoluteString] isEqualToString:@"(null)"])
    {
        NSLog(@"%@",n.imageUrl);
    
        cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[n.imageUrl absoluteString]]]];
    }else{
        NSLog(@"use empty box image");
        UIImage * image = [UIImage imageNamed:@"emptybox.gif"];
        cell.image.image = image;
    
    }
return cell;
}

-(void)getNews
{
    UIAlertView *loadingAlert;
    
    loadingAlert = [[UIAlertView alloc] initWithTitle:@"Loading news\nPlease Wait..."
                                              message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    
    UIActivityIndicatorView *in = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [in startAnimating];
    [loadingAlert setValue:in forKey:@"accessoryView"];
    [loadingAlert show];
    
    NSURL* url = [NSURL URLWithString:@"http://ajax.googleapis.com/ajax/services/feed/load?v=1.0&q=http://www.abc.net.au/news/feed/51120/rss.xml&num=-1"];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     {
         if(error == nil)
         {
             [self parseJSON:data];
             [self.tableView reloadData];
             [loadingAlert dismissWithClickedButtonIndex:0 animated:TRUE];
         }
         else
         {
             [loadingAlert dismissWithClickedButtonIndex:0 animated:TRUE];
             UIAlertView *noConnectionAlert = [[UIAlertView alloc] initWithTitle:@"Notice!"
                                                                         message:@"check your Internet connection!"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Yes"
                                                               otherButtonTitles:nil];
             noConnectionAlert.tag = 100;
             [noConnectionAlert show];
             NSLog(@"Connection Error:\n%@", error.userInfo);
         } }];
}

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 100) {
        [self getNews];
    }
}




-(void)parseJSON:(NSData*)data
{
    NSError* error;
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    if(result == nil) {
        NSLog(@"Error parsing JSON:\n%@", error.userInfo);
        return;
    }
    if([result isKindOfClass:[NSDictionary class]])
    {
        NSLog(@"Found news!");
        NSDictionary *responseData = [result objectForKey:@"responseData"];
        NSDictionary *feed = [responseData objectForKey:@"feed"];
        NSArray *entries = [feed objectForKey:@"entries"];
        for(NSDictionary * news in entries)
        {
            NSDictionary *jsontitle = [news objectForKey:@"title"];
            NSDictionary *jsondescriptions = [news objectForKey:@"content"];
            NSDictionary *jsonuimageurl = [[[[[[[news objectForKey:@"mediaGroups"] objectAtIndex:0] objectForKey:@"contents"] objectAtIndex:0] objectForKey:@"thumbnails"] objectAtIndex:0]objectForKey:@"url"];
            NSDictionary *jsonlink = [news objectForKey:@"link"];
            News* n = [[News alloc] init];
            n.title = [[NSString alloc] initWithFormat:@"%@",jsontitle];
            n.imageUrl = [NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",jsonuimageurl]];
            n.webLink =[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",jsonlink]];
            n.descriptions  = [[[[NSString alloc] initWithFormat:@"%@",jsondescriptions] stringByReplacingOccurrencesOfString:@"<p>" withString:@""] stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            
            
            [self.newsList addObject:n];

            
        }
    }
    else
    {
        NSLog(@"Not a Json");
        return;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    return [self.currentList count];
//}
//
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"did select at %ld",indexPath.row);
//    self.currentIndex = (int)indexPath.row;
//    _editcontroller.currentReminder = [self.currentList objectAtIndex:indexPath.row];
//}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if([segue.identifier isEqualToString:@"NewsDetail"])
    {
        WebViewController* controller = segue.destinationViewController;
        NSURL* url;
        News* n = (News *)[self.newsList objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
        url = n.webLink;
        controller.webLink = url;
    }
    
    
}


@end
