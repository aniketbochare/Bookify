//
//  AddBookViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DetailBookViewController;
@class BookListItem;

@protocol AddBookViewControllerDelegate <NSObject>

- (void)addBookViewControllerDidCancel: (DetailBookViewController *)controller;
/*Protocol function to add new book*/

- (void)addBookViewController: (DetailBookViewController *)controller didFinishAddingBook:(BookListItem*)book;

/*Protocol function to edit new book*/

- (void)addBookViewController: (DetailBookViewController *)controller didFinishEditingBook:(BookListItem*)book;



@end

@interface DetailBookViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bookTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <AddBookViewControllerDelegate> delegate;

@property (nonatomic, strong) BookListItem *bookToEdit;


- (IBAction)cancel;
- (IBAction)done;

@end