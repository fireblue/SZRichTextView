//
//  SZTextObject.h
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-29.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZRichTextObject.h"

@interface SZText : SZRichTextObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic) CGSize boundingSize;

@end
