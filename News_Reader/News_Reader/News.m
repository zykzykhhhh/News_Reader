//
//  News.m
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import "News.h"

@implementation News
-(id)init{
    self = [super init];
    
    return self;
    
}
-(id)initWith:(NSString*)title description:(NSString*) descriptions imageUrl:(NSURL*) imageUrl andwebLink:(NSURL*)webLink
{
    if(self = [super init])
    {
        self.title = title;
        self.descriptions = descriptions;
        self.imageUrl = imageUrl;
        self.webLink = webLink;
    }
    return self;
}
@end
