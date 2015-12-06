//
//  News.h
//  News_Reader
//
//  Created by Yukun Zhang on 27/04/2015.
//  Copyright (c) 2015 Yukun Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface News : NSObject
@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) NSString* descriptions;
@property (strong, nonatomic) NSURL* webLink;
@property (strong, nonatomic) NSURL* imageUrl;



-(id)init;
-(id)initWith:(NSString*)title description:(NSString*) descriptions imageUrl:(NSURL*) imageUrl andwebLink:(NSURL*)webLink;
@end
