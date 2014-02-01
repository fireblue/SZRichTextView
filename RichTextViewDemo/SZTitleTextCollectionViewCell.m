//
//  SZTitleTextCollectionViewCell.m
//  RichTextViewDemo
//
//  Created by Zongxuan Su on 14-2-1.
//  Copyright (c) 2014年 SZX. All rights reserved.
//

#import "SZTitleTextCollectionViewCell.h"
#import "SZTitleText.h"

@interface SZTitleTextCollectionViewCell () <UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UITextField *titleTextField;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, weak) SZTitleText *richTextObject;

@end

@implementation SZTitleTextCollectionViewCell

@synthesize richTextObject = _richTextObject;

- (void)setRichTextObject:(SZTitleText *)richTextObject
{
    self.titleLabel.text = richTextObject.displayTitle;
    self.titleTextField.text = richTextObject.text;
    _richTextObject = richTextObject;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.richTextObject.text = textField.text;
}

@end
