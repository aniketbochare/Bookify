//
//  BookDetailViewController.m
//  Bookify
//
//  Created by Aniket Bochare on 10/8/14.
//  Copyright (c) 2014 Coral. All rights reserved.
//

#import "BookDetailViewController.h"
#import "BookListItem.h"

@interface BookDetailViewController ()

@end

@implementation BookDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
        if (self.bookToEdit != nil)
    {
        self.title = @"Edit Book";
        self.BookTitle.text = self.bookToEdit.BookTitle;
        self.doneBarButton.enabled = YES;
    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.BookTitle becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel
{
    
    [self.delegate bookDetailViewControllerDidCancel:self];
    
}

- (IBAction)done {
    
    NSLog(@"Calling Done");
    
    if (self.bookToEdit.BookTitle)
    {
        self.bookToEdit.BookTitle = self.BookTitle.text;
        [self.delegate bookDetailViewController:self didFinishEditingBook:self.bookToEdit];
    }
    else{
        BookListItem *newbook = [[BookListItem alloc] init];
        newbook.BookTitle = self.BookTitle.text;
        
        [self.delegate bookDetailViewController:self didFinishAddingBook:newbook];
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
