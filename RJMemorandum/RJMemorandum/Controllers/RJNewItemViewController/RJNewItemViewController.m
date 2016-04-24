//
//  RJNewItemViewController.m
//  RJMemorandum
//
//  Created by RenJiaLiang on 16/4/23.
//  Copyright © 2016年 Renjialiang. All rights reserved.
//

#import "RJNewItemViewController.h"
#import "RJMacro.h"
#import "RJItemStore.h"
#import "ICTextView.h"
@interface RJNewItemViewController()<UITextFieldDelegate,UITextViewDelegate,UISearchBarDelegate>{
    UILabel *_titleLabel;
    UITextField *_titleTextField;
    BOOL canSave;
    BOOL isNew;
}
@property (nonatomic, strong) ICTextView *textView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UILabel *countLabel;
@end
@implementation RJNewItemViewController
#pragma mark - Properties

@synthesize countLabel = _countLabel;
@synthesize searchBar = _searchBar;
@synthesize textView = _textView;
@synthesize toolBar = _toolBar;

#pragma mark - Self

- (void)loadView
{
    [super loadView];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar = searchBar;
    searchBar.delegate = self;
    
    if ([searchBar respondsToSelector:@selector(setInputAccessoryView:)])
    {
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        
        UIBarButtonItem *prevButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Prev"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(searchPreviousMatch)];
        
        UIBarButtonItem *nextButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                           style:UIBarButtonItemStylePlain
                                                                          target:self
                                                                          action:@selector(searchNextMatch)];
        
        UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UILabel *countLabel = [[UILabel alloc] init];
        countLabel.textAlignment = NSTextAlignmentRight;
        countLabel.textColor = [UIColor grayColor];
        
        UIBarButtonItem *counter = [[UIBarButtonItem alloc] initWithCustomView:countLabel];
        
        toolBar.items = [[NSArray alloc] initWithObjects:prevButtonItem, nextButtonItem, spacer, counter, nil];
        
        [(id)searchBar setInputAccessoryView:toolBar];
        
        self.toolBar = toolBar;
        self.countLabel = countLabel;
    }
    
    ICTextView *textView = [[ICTextView alloc] initWithFrame:CGRectZero];
    self.textView = textView;
    textView.font = [UIFont systemFontOfSize:14.0];
    textView.circularSearch = YES;
    textView.scrollPosition = ICTextViewScrollPositionMiddle;
    textView.searchOptions = NSRegularExpressionCaseInsensitive;
    textView.delegate = self;
    [self.view addSubview:textView];
    [self.view addSubview:searchBar];
}

-(instancetype) init{
    self = [super init];
    if (self) {
        canSave = NO;
        isNew = YES;
    }
    return self;
}
#pragma mark - Life cycle
-(void) viewDidLoad{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self.view setBackgroundColor:RGBCOLOR(224, 224, 224)];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    _titleLabel.font = RJFont(18);
    _titleLabel.textColor = RGBACOLOR(0, 0, 0, 0.64);
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"新记录";
    self.navigationItem.titleView = _titleLabel;
    UIBarButtonItem *leftNavBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = leftNavBarButtonItem;
    UIBarButtonItem *rightNavBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem = rightNavBarButtonItem;
    [self updateRightBarButtonItem];
    _titleTextField = [[UITextField alloc]initWithFrame:CGRectMake(0, 5, self.view.frame.size.width, 50)];
    _titleTextField.backgroundColor = [UIColor whiteColor];
    _titleTextField.delegate = self;
    _titleTextField.textColor = RJTitleColor;
    _titleTextField.font = RJFont(18);
    _titleTextField.borderStyle = UITextBorderStyleRoundedRect;
    _titleTextField.textAlignment = NSTextAlignmentCenter;
    _titleTextField.attributedPlaceholder = [[NSAttributedString alloc]initWithString:@"标题" attributes:@{NSForegroundColorAttributeName:RJContentColor,NSFontAttributeName:RJFont(18)}];
    [self.view addSubview:_titleTextField];
    [_titleTextField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self updateTextViewInsetsWithKeyboardNotification:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateTextViewInsetsWithKeyboardNotification:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    [self updateCountLabel];
}
- (void)viewDidLayoutSubviews
{
    CGRect viewBounds = self.view.bounds;
    viewBounds.origin.y = 60;
    
    CGRect searchBarFrame = viewBounds;
    searchBarFrame.size.height = 44.0f;
    
    CGRect toolBarFrame = viewBounds;
    toolBarFrame.size.height = 34.0f;
    
    self.searchBar.frame = searchBarFrame;
    self.toolBar.frame = toolBarFrame;
    self.textView.frame = viewBounds;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.searchBar becomeFirstResponder];
    [self.textView scrollRectToVisible:CGRectZero animated:YES consideringInsets:YES];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
#pragma mark - UITextField Delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [_textView becomeFirstResponder];
    return YES;
}
#pragma mark - UITextView Delegate
-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    canSave = [_titleTextField.text length] * [text length];
    [self updateRightBarButtonItem];
    return YES;
}
#pragma mark - ACtion
-(void) textChange:(id) sender{
    canSave = [_titleTextField.text length] * [_textView.text length];
    [self updateRightBarButtonItem];
}
-(void) leftBtnAction{
   [self dismissViewControllerAnimated:YES completion:nil];
}
-(void) rightBarButtonItemAction{
    if ([self checkItem]) {
        if (isNew) {
            [[RJItemStore shareStore]creatNewRJItemWith:_titleTextField.text content:_textView.text];
        }
        else{
            
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
- (void)updateRightBarButtonItem {
    self.navigationItem.rightBarButtonItem.enabled = canSave;
}
-(BOOL) checkItem{
    BOOL isValid = [_titleTextField.text length] * [_textView.text length];
    if(!isValid){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"标题和内容不能为空" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    return isValid;
}
#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    _Pragma("unused(searchBar, searchText)")
    [self searchNextMatch];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    _Pragma("unused(searchBar)")
    [self.textView becomeFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    _Pragma("unused(searchBar)")
    [self searchNextMatch];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [self.textView resetSearch];
    [self updateCountLabel];
}

#pragma mark - ICTextView

- (void)searchNextMatch
{
    [self searchMatchInDirection:ICTextViewSearchDirectionForward];
}

- (void)searchPreviousMatch
{
    [self searchMatchInDirection:ICTextViewSearchDirectionBackward];
}

- (void)searchMatchInDirection:(ICTextViewSearchDirection)direction
{
    NSString *searchString = self.searchBar.text;
    
    if (searchString.length)
        [self.textView scrollToString:searchString searchDirection:direction];
    else
        [self.textView resetSearch];
    
    [self updateCountLabel];
}

- (void)updateCountLabel
{
    ICTextView *textView = self.textView;
    UILabel *countLabel = self.countLabel;
    
    NSUInteger numberOfMatches = textView.numberOfMatches;
    countLabel.text = numberOfMatches ? [NSString stringWithFormat:@"%lu/%lu", (unsigned long)textView.indexOfFoundString + 1, (unsigned long)numberOfMatches] : @"0/0";
    [countLabel sizeToFit];
}

#pragma mark - Keyboard

- (void)updateTextViewInsetsWithKeyboardNotification:(NSNotification *)notification
{
    UIEdgeInsets newInsets = UIEdgeInsetsZero;
    newInsets.top = self.searchBar.frame.size.height;
    
    if (notification)
    {
        CGRect keyboardFrame;
        
        [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
        keyboardFrame = [self.view convertRect:keyboardFrame fromView:nil];
        
        newInsets.bottom = self.view.frame.size.height - keyboardFrame.origin.y;
    }
    
    ICTextView *textView = self.textView;
    textView.contentInset = newInsets;
    textView.scrollIndicatorInsets = newInsets;
}

@end
