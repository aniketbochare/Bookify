//
//  BooksTableViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookDetailViewController.h"


@class DataModel;

@interface BooksTableViewController : UITableViewController <BookDetailViewControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

@end
