//
//  DataModel.m
//  Bookify
//
//  Created by Aniket Bochare on 10/12/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "DataModel.h"
#import "BookListItem.h"

@implementation DataModel

/*Adding persistance to the data. Data stores in document directory and hence sandboxed*/


- (id)init
{
    if ((self = [super init]))
    {
        [self loadBookListItems];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

- (NSString *)pathToDocumentDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths firstObject];
    return documentsDirectoryPath;
}

- (NSString *)pathTotheFile
{
    return [[self pathToDocumentDirectory] stringByAppendingPathComponent:@"BookList.plist"];
}

- (void)saveBookListItems
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.books forKey:@"BookListItem"];
    [archiver finishEncoding];
    [data writeToFile:[self pathTotheFile] atomically:YES];
}

- (void)loadBookListItems {
    NSString *path = [self pathTotheFile];
    NSLog(@"Path= %@",path);
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSLog(@"came plist");
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        self.books = [unarchiver decodeObjectForKey:@"BookListItem"];
        [unarchiver finishDecoding];
    }
    else
    {
        NSLog(@"came here");
        self.books = [[NSMutableArray alloc] initWithCapacity:20];
        
    }
}

//NSUserDefaults code in datamodel

- (void)registerDefaults
{
    NSDictionary *defaultDictionary = @{
                                 @"BookListItemIndex" : @-1,
                                 @"isFirstTime" :@YES
                                 };
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultDictionary];
}

- (NSInteger)indexOfSelectedBook
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"BookListItemIndex"];
}

- (void)setIndexOfSelectedBook:(NSInteger)index
{
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"BookListItemIndex"];
}

-(void)handleFirstTime
{
   BOOL isFirstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"isFirstTime"];
    if (isFirstTime)
    {
        BookListItem *firstBook = [[BookListItem alloc] init];
        firstBook.BookTitle = @"Reminders";
        [self.books addObject:firstBook];
        [self setIndexOfSelectedBook:0];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isFirstTime"];
    }

}

- (void)sortBookLists
{
    [self.books sortUsingSelector:@selector(compare:)];
}

@end
