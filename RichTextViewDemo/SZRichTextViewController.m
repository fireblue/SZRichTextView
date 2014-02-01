//
//  SZRichTextViewController.m
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZRichTextViewController.h"
#import "SZTextCollectionViewCell.h"
#import "SZImageCollectionViewCell.h"
#import "SZTitleTextCollectionViewCell.h"
#import "SZText.h"
#import "SZImage.h"
#import "SZTitleText.h"
#import "PSTCollectionView.h"

@interface SZRichTextViewController () <PSTCollectionViewDataSource, PSTCollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *richTextObjects;

@property (nonatomic, strong) UIBarButtonItem *doneButtonItem;
@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation SZRichTextViewController

- (void)loadView
{
    [super loadView];
    
    PSTCollectionViewFlowLayout *aFlowLayout = [[PSTCollectionViewFlowLayout alloc] init];
    [aFlowLayout setScrollDirection:PSTCollectionViewScrollDirectionVertical];
    self.collectionView = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height) collectionViewLayout:aFlowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.view addSubview:self.collectionView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerNib:[UINib nibWithNibName:SZTextCollectionViewCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:SZTextCollectionViewCellReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:SZImageCollectionViewCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:SZImageCollectionViewCellReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:SZTitleTextCollectionViewCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:SZTitleTextCollectionViewCellReuseIdentifier];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addImage:)];
    self.navigationItem.rightBarButtonItems = @[imageItem, self.doneButtonItem];
    
    self.navigationItem.title = @"SZRichTextViewDemo";
    
    SZTitleText *title = [[SZTitleText alloc] init];
    title.displayTitle = @"标  题";
    
    SZTitleText *receipt = [[SZTitleText alloc] init];
    receipt.displayTitle = @"收件人";
    
    SZText *text = [[SZText alloc] init];
    self.richTextObjects = [NSMutableArray arrayWithObjects:title, receipt, text, nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
	// Do any additional setup after loading the view.
}

- (UIBarButtonItem *)doneButtonItem
{
    if (_doneButtonItem == nil) {
        _doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed:)];
    }
    return _doneButtonItem;
}

- (UIButton *)doneButton
{
    if (_doneButton == nil) {
        _doneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_doneButton setTitle:@"完成" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

- (void)doneButtonPressed:(id)sender
{
    
    if (![self.delegate respondsToSelector:@selector(richTextViewController:shouldFinishEditingWithContent:)] && ![self.delegate richTextViewController:self shouldFinishEditingWithContent:self.richTextObjects]) {
        NSLog(@"Validation failed.");
    }
    else
    {
        [self.delegate richTextViewController:self didFinishEditingWithContent:self.richTextObjects];
        
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.richTextObjects.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZRichTextObject *object = self.richTextObjects[indexPath.row];
    NSLog(@"CALCULATED SIZE: %@", NSStringFromCGSize(object.size));
    return object.size;
}

- (PSTCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZRichTextObject *object = self.richTextObjects[indexPath.row];
    
    if ([object isKindOfClass:[SZTitleText class]]) {
        SZTitleTextCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:SZTitleTextCollectionViewCellReuseIdentifier forIndexPath:indexPath];
        cell.richTextObject = object;
        cell.parent = self;
        return cell;
    }
    if ([object isKindOfClass:[SZText class]]) {
        SZTextCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:SZTextCollectionViewCellReuseIdentifier forIndexPath:indexPath];
        cell.richTextObject = object;
        cell.parent = self;
        return cell;
    }
    if ([object isKindOfClass:[SZImage class]]) {
        SZImageCollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:SZImageCollectionViewCellReuseIdentifier forIndexPath:indexPath];
        cell.richTextObject = object;
        cell.parent = self;
        return cell;
    }
    else {
        assert(@"seriously this should never happen");
        return nil;
    }
}

- (void)keyboardFrameDidChange:(NSNotification *)notification
{
    NSValue *endValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:endValue.CGRectValue fromView:nil];
    
    UIEdgeInsets edgeInset = self.collectionView.contentInset;
    edgeInset.bottom = keyboardRect.size.height;
    
    self.collectionView.contentInset = edgeInset;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    NSValue *endValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:endValue.CGRectValue fromView:nil];
    
    UIEdgeInsets edgeInset = self.collectionView.contentInset;
    edgeInset.bottom = keyboardRect.size.height;
    
    self.collectionView.contentInset = edgeInset;
    [self scrollToCursor:self.activeTextView];
}

- (void)scrollToCursor:(UITextView *)textView
{
    if (!textView) {
        return;
    }
    // if there is a selection cursor…
    if(textView.selectedRange.location != NSNotFound) {
        // work out how big the text view would be if the text only went up to the cursor
        NSRange range;
        range.location = textView.selectedRange.location;
        range.length = textView.text.length - range.location;
        NSString *string = [textView.text stringByReplacingCharactersInRange:range withString:@""];
        if ([string isEqualToString:@""]) {
            string = @"s";
        }
        CGSize size = [string sizeWithFont:textView.font constrainedToSize:textView.bounds.size lineBreakMode:UILineBreakModeWordWrap];
        
        // work out where that position would be relative to the textView's frame
        CGRect viewRect = [self.view convertRect:textView.frame fromView:textView.superview];
        int scrollHeight = viewRect.origin.y + size.height;
        CGRect finalRect = CGRectMake(1, scrollHeight, 1, 1);
        
        [self.collectionView scrollRectToVisible:finalRect animated:YES];
    }
}

- (void)keyboardDidHide:(NSNotification *)notification
{
    UIEdgeInsets edgeInset = self.collectionView.contentInset;
    edgeInset.bottom = 0;
    self.collectionView.contentInset = edgeInset;
}

- (IBAction)addImage:(id)sender
{
    NSString *stringBeforeSelection = nil;
    NSString *stringAfterSelection = nil;
    
    if (self.activeTextView && self.activeText) {
        NSRange selectedRange = self.activeTextView.selectedRange;
        stringBeforeSelection = [self.activeText.text substringToIndex:selectedRange.location];
        stringAfterSelection = [self.activeText.text substringFromIndex:selectedRange.location];
        if ([stringAfterSelection hasPrefix:@"\n"]) {
            stringAfterSelection = [stringAfterSelection substringFromIndex:1];
        }
        self.activeTextView.text = stringBeforeSelection;
        self.activeText.text = stringBeforeSelection;
    }
    
    SZImage *image = [[SZImage alloc] init];
    image.underlyingImage = [UIImage imageNamed:@"IMG_3429"];
    [self.richTextObjects addObject:image];
    SZText *text = [[SZText alloc] init];
    text.text = stringAfterSelection;
    [self.richTextObjects addObject:text];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)deleteImage:(SZImage *)image
{
    if (image) {
        NSInteger index = [self.richTextObjects indexOfObject:image];
        if (index-1 >= 0 && index+1 < self.richTextObjects.count) {
            SZRichTextObject *objectBeforeImage = self.richTextObjects[index-1];
            SZRichTextObject *objectAfterImage = self.richTextObjects[index+1];
            if ([objectBeforeImage isKindOfClass:[SZText class]] && [objectAfterImage isKindOfClass:[SZText class]]) {
                SZText *textBeforeImage = (SZText *)objectBeforeImage;
                SZText *textAfterImage = (SZText *)objectAfterImage;
                textBeforeImage.text = [NSString stringWithFormat:@"%@\n%@", textBeforeImage.text, textAfterImage.text];
                [self.richTextObjects removeObject:image];
                [self.richTextObjects removeObject:textAfterImage];
                [[NSNotificationCenter defaultCenter] postNotificationName:SZTextCollectionViewCellForceResizeNotification object:nil];
                [self.collectionView reloadData];
            }
        }
    }
}

@end
