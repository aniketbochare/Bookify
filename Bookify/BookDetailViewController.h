//
//  BookDetailViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerTableViewController.h"


@class BookDetailViewController;
@class BookListItem;

@protocol BookDetailViewControllerDelegate <NSObject,IconPickerControllerDelegate>

- (void)bookDetailViewControllerDidCancel: (BookDetailViewController *)controller;
/*Protocol function to add new book*/

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishAddingBook:(BookListItem*)book;

/*Protocol function to edit new book*/

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishEditingBook:(BookListItem*)book;



@end

@interface BookDetailViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *BookTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (nonatomic, weak) id <BookDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) BookListItem *bookToEdit;


- (IBAction)cancel;
- (IBAction)done;

@end
