//
//  SZRichTextViewController.h
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"

@interface SZRichTextViewController : UIViewController

@property (nonatomic, strong) PSTCollectionView *collectionView;
@property (nonatomic, weak) UITextView *activeTextView;

@end
