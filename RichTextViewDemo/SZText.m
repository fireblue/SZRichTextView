//
//  SZTextObject.m
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-29.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZText.h"

@implementation SZText

- (id)init
{
    self = [super init];
    if (self) {
        self.size = CGSizeMake(320, 40);
        self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
        self.boundingSize = CGSizeMake(320, MAXFLOAT);
    }
    return self;
}

- (CGSize)size
{
    CGRect calculatedRect = [self.text boundingRectWithSize:self.boundingSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:[NSStringDrawingContext new]];
    CGSize calculatedSize = calculatedRect.size;
    calculatedSize.width = MAX(calculatedSize.width, self.boundingSize.width);
    calculatedSize.height = MAX(calculatedSize.height, 40);
    return calculatedSize;
}

@end
