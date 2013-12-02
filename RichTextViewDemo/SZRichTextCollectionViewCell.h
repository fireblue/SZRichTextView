//
//  SZRichTextCollectionViewCell.h
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-29.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZRichTextObject.h"
#import "PSTCollectionViewCell.h"
#import "SZRichTextViewController.h"

@interface SZRichTextCollectionViewCell : PSTCollectionViewCell

@property (nonatomic, weak) SZRichTextObject *richTextObject;
@property (nonatomic, weak) SZRichTextViewController *parent;

@end
