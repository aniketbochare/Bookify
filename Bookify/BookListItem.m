//
//  BookListItem.m
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BookListItem.h"
#import "PageListItem.h"

@implementation BookListItem

- (id)init {
    if ((self = [super init])) {
        self.pages = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"Arts";
    }
    return self;
}



/*Implementing NScoding protocol methods for BooklistItem. This will help us to save data on disk*/

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.BookTitle forKey:@"BookTitle"];
    [aCoder encodeObject:self.pages forKey:@"pages"];
    [aCoder encodeObject:self.iconName forKey:@"IconName"];
    
    
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.BookTitle= [aDecoder decodeObjectForKey:@"BookTitle"];
        self.pages= [aDecoder decodeObjectForKey:@"pages"];
        self.iconName = [aDecoder decodeObjectForKey:@"IconName"];
    }
    return self;
}


- (int)countIncompletePages
{
    int unCheckedPageCount = 0;
    for (PageListItem *page in self.pages)
    {
        if (!page.checked)
        {
            unCheckedPageCount += 1;
        }
    }
    return unCheckedPageCount;
}

- (NSComparisonResult)compare:(BookListItem *)otherBookList
{
 return [self.BookTitle localizedStandardCompare: otherBookList.BookTitle];
}


@end
