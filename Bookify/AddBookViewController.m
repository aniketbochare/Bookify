//
//  AddBookViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "AddBookViewController.h"
#import "BookListItem.h"

@interface AddBookViewController ()

@end

@implementation AddBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.bookTitle becomeFirstResponder];
}

- (IBAction)cancel {
    
    [self.delegate addBookViewControllerDidCancel:self];
    
}

- (IBAction)done {
    
    BookListItem *newbook = [[BookListItem alloc] init];
    newbook.bookTitle = self.bookTitle.text;
    newbook.checked = NO;
    
    [self.delegate addBookViewController:self didFinishAddingBook:newbook];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
self.doneBarButton.enabled = ([newText length] > 0);
return YES;
}

@end
