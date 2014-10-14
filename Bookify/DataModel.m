//
//  DataModel.m
//  Bookify
//
//  Created by Aniket Bochare on 10/12/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "DataModel.h"

@implementation DataModel

/*Adding persistance to the data. Data stores in document directory and hence sandboxed*/


- (id)init
{
    if ((self = [super init]))
    {
        [self loadBookListItems];
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




@end
