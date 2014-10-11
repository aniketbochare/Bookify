//
//  BookListItem.m
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BookListItem.h"

@implementation BookListItem

- (id)init {
    if ((self = [super init])) {
        self.pages = [[NSMutableArray alloc] initWithCapacity:20];
    }
    return self;
}



/*Implementing NScoding protocol methods for BooklistItem. This will help us to save data on disk*/

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.BookTitle forKey:@"BookTitle"];
    [aCoder encodeObject:self.pages forKey:@"pages"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.BookTitle= [aDecoder decodeObjectForKey:@"BookTitle"];
        self.pages= [aDecoder decodeObjectForKey:@"pages"];
    }
    return self;
}


@end
