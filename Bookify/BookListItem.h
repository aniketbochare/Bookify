//
//  BookListItem.h
//  Bookify
//
//  Created by Aniket Bochare on 10/4/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *bookTitle;
/* Here we use copy but we can use strong and be fine. We will mostly use copy so we can modify objects and noone can. WE own this. Mostly for mutable
However, for NSStrings (and NSArray and several other classes) it is best practice to use copy, because you don't want any of the other owners (if there are any) to modify this object afterwards.
 */
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;

@end
