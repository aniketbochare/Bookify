//
//  BookListItem.h
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookListItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *BookTitle;
@property (nonatomic, strong) NSMutableArray *pages;

@end
