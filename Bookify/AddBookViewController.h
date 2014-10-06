//
//  AddBookViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>


@class AddBookViewController;
@class BooklistItem;

@protocol AddBookViewControllerDelegate <NSObject>

- (void)addBookViewControllerDidCancel: (AddBookViewController *)controller;
- (void)addBookViewController: (AddBookViewController *)controller didFinishAddingBook:(BooklistItem*)book;

@end

@interface AddBookViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bookTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <AddBookViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)done;

@end
