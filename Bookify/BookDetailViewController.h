//
//  BookDetailViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>


@class BookDetailViewController;
@class BookListItem;

@protocol BookDetailViewControllerDelegate <NSObject>

- (void)bookDetailViewControllerDidCancel: (BookDetailViewController *)controller;
/*Protocol function to add new book*/

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishAddingBook:(BookListItem*)book;

/*Protocol function to edit new book*/

- (void)bookDetailViewController: (BookDetailViewController *)controller didFinishEditingBook:(BookListItem*)book;



@end

@interface BookDetailViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bookTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <BookDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) BookListItem *bookToEdit;


- (IBAction)cancel;
- (IBAction)done;

@end
