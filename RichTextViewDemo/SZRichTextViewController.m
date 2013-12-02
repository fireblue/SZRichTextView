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
#import "SZText.h"
#import "SZImage.h"
#import "PSTCollectionView.h"

@interface SZRichTextViewController () <PSTCollectionViewDataSource, PSTCollectionViewDelegate>


@property (nonatomic, strong) NSMutableArray *richTextObjects;

@end

@implementation SZRichTextViewController

- (void)loadView
{
    [super loadView];
    
    
    PSTCollectionViewFlowLayout *aFlowLayout = [[PSTCollectionViewFlowLayout alloc] init];
    [aFlowLayout setScrollDirection:PSTCollectionViewScrollDirectionVertical];
    self.collectionView = [[PSTCollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, 480) collectionViewLayout:aFlowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:SZTextCollectionViewCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:SZTextCollectionViewCellReuseIdentifier];
    [self.collectionView registerNib:[UINib nibWithNibName:SZImageCollectionViewCellReuseIdentifier bundle:nil] forCellWithReuseIdentifier:SZImageCollectionViewCellReuseIdentifier];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *textItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(addText:)];
    UIBarButtonItem *imageItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(addImage:)];
    self.navigationItem.rightBarButtonItems = @[textItem, imageItem];
    
    self.navigationItem.title = @"SZRichTextViewTest";
    
    SZText *text = [[SZText alloc] init];
    self.richTextObjects = [NSMutableArray arrayWithObject:text];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardDidHideNotification object:nil];
    
	// Do any additional setup after loading the view.
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
    NSLog(@"cell size: %@", NSStringFromCGSize(object.size));
    NSLog(@"view size: %@", NSStringFromCGSize(self.collectionView.frame.size));
    return object.size;
}

- (PSTCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZRichTextObject *object = self.richTextObjects[indexPath.row];
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
        NSLog(@"seriously this should never happen");
        return nil;
    }
}

- (void)keyboardFrameDidChange:(NSNotification *)notification
{
    NSValue *endValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [self.view convertRect:endValue.CGRectValue fromView:nil];
    self.collectionView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height-keyboardRect.size.height);
}

- (IBAction)addImage:(id)sender
{
    SZImage *image = [[SZImage alloc] init];
    image.displayImage = [UIImage imageNamed:@"IMG_3429"];
    [self.richTextObjects addObject:image];
    SZText *text = [[SZText alloc] init];
    [self.richTextObjects addObject:text];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (IBAction)addText:(id)sender
{
    SZText *text = [[SZText alloc] init];
    [self.richTextObjects addObject:text];
    [self.collectionView reloadData];
}
@end
