//
//  SZTextCollectionViewCell.m
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZTextCollectionViewCell.h"
#import "SZText.h"

@interface SZTextCollectionViewCell () <UITextViewDelegate>

@property (nonatomic, weak) SZText *richTextObject;
@property (nonatomic, strong) IBOutlet UITextView *textView;

@end

@implementation SZTextCollectionViewCell

@synthesize richTextObject = _richTextObject;

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self registerKVO];
}

- (void)registerKVO
{
    self.textView.delegate = self;
    self.richTextObject.size = self.textView.frame.size;
}

- (void)setRichTextObject:(SZText *)richTextObject
{
    self.textView.text = richTextObject.text;
    _richTextObject = richTextObject;
}

- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat originalHeight = textView.frame.size.height;
    CGFloat fixedWidth = textView.frame.size.width;
    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    textView.frame = newFrame;
    if (originalHeight != newSize.height) {
        self.richTextObject.size = newFrame.size;
        [self.parent.collectionView.collectionViewLayout invalidateLayout];
    }
    self.richTextObject.text = textView.text;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.parent.activeTextView = textView;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    self.parent.activeTextView = nil;
}


@end
