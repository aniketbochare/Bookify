//
//  DataModel.h
//  Bookify
//
//  Created by Aniket Bochare on 10/12/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

 @property (nonatomic, strong)  NSMutableArray *books;

 - (void)saveBookListItems;
 - (NSInteger)indexOfSelectedBook;
 - (void)setIndexOfSelectedBook:(NSInteger)index;
 - (void)sortBookLists;

@end
