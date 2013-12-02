//
//  SZTextCollectionViewCell.h
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZRichTextCollectionViewCell.h"

#define SZTextCollectionViewCellReuseIdentifier @"SZTextCollectionViewCell"

#define SZTextCollectionViewCellForceResizeNotification @"SZTextCollectionViewCellForceResizeNotification"

@interface SZTextCollectionViewCell : SZRichTextCollectionViewCell

@property (nonatomic, readonly) UITextView *textView;

@end
