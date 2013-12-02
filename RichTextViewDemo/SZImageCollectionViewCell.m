//
//  SZImageCollectionViewCell.m
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZImageCollectionViewCell.h"
#import "SZImage.h"

@interface SZImageCollectionViewCell ()

@property (nonatomic, weak) SZImage *richTextObject;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation SZImageCollectionViewCell

@synthesize richTextObject = _richTextObject;

- (void)setRichTextObject:(SZImage *)richTextObject
{
    self.imageView.image = richTextObject.displayImage;
    self.imageView.frame = CGRectMake(0, 0, 320, 320);
    richTextObject.size = CGSizeMake(320, 320);
    _richTextObject = richTextObject;
}

@end
