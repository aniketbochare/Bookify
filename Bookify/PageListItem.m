//
//  BookListItem.m
//  Bookify
//
//  Created by Aniket Bochare on 10/4/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "PageListItem.h"

@implementation PageListItem

- (void)toggleChecked
{
    self.checked = !self.checked;
}

/*Implementing NScoding protocol methods for BooklistItem. This will help us to save data on disk*/

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.PageTitle forKey:@"PageTitle"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];

}

 -(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.PageTitle= [aDecoder decodeObjectForKey:@"PageTitle"];
        self.checked= [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
}

@end


