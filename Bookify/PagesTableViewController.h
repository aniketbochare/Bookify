//
//  PagesTableViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/4/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageDetailViewController.h"

@class BookListItem;

@interface PagesTableViewController : UITableViewController<PageDetailViewControllerDelegate>

@property (nonatomic, strong) BookListItem *selectedBook;

//- (IBAction)addPage;

@end
