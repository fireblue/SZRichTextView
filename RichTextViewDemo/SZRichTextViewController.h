//
//  SZRichTextViewController.h
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"
#import "SZText.h"
#import "SZImage.h"

@protocol SZRichTextViewController;

@interface SZRichTextViewController : UIViewController

@property (nonatomic, strong) PSTCollectionView *collectionView;
@property (nonatomic, weak) SZText *activeText;
@property (nonatomic, weak) UITextView *activeTextView;

@property (nonatomic, readonly) UIBarButtonItem *doneButtonItem;
@property (nonatomic, readonly) UIButton *doneButton;

@property (nonatomic, weak) id<SZRichTextViewController> delegate;

- (void)deleteImage:(SZImage *)image;

@end

@protocol SZRichTextViewController <NSObject>

- (void)richTextViewController:(SZRichTextViewController *)richTextViewController didFinishEditingWithContent:(NSArray *)content;
- (BOOL)richTextViewController:(SZRichTextViewController *)richTextViewController shouldFinishEditingWithContent:(NSArray *)content;

@end
