//
//  PageDetailViewController.h
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import <UIKit/UIKit.h>


@class PageDetailViewController;
@class PageListItem;

@protocol PageDetailViewControllerDelegate <NSObject>

- (void)pageDetailViewControllerDidCancel: (PageDetailViewController *)controller;
/*Protocol function to add new page*/

- (void)pageDetailViewController: (PageDetailViewController *)controller didFinishAddingPage:(PageListItem*)page;

/*Protocol function to edit new page*/

- (void)pageDetailViewController: (PageDetailViewController *)controller didFinishEditingPage:(PageListItem*)page;



@end

@interface PageDetailViewController : UITableViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *PageTitle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <PageDetailViewControllerDelegate> delegate;

@property (nonatomic, strong) PageListItem *pageToEdit;


- (IBAction)cancel;
- (IBAction)done;

@end
