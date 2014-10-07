//
//  AddBookViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/5/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "DetailBookViewController.h"
#import "BookListItem.h"

@interface DetailBookViewController ()

@end

@implementation DetailBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    if (self.bookToEdit != nil) {
        self.title = @"Edit Item";
        self.bookTitle.text = self.bookToEdit.bookTitle;
    }
    
    NSLog(@"Inside View load");
    
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

- (IBAction)cancel
{
    
    [self.delegate addBookViewControllerDidCancel:self];
    
}

- (IBAction)done {
    
     NSLog(@"Calling Done");
    
    if (self.bookToEdit.bookTitle)
    {
        self.bookToEdit.bookTitle = self.bookTitle.text;
        [self.delegate addBookViewController:self didFinishEditingBook:self.bookToEdit];
    }
    else{
    BookListItem *newbook = [[BookListItem alloc] init];
    newbook.bookTitle = self.bookTitle.text;
    newbook.checked = NO;
    
    [self.delegate addBookViewController:self didFinishAddingBook:newbook];
    }
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
