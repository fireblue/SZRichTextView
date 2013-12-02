//
//  SZImageObject.h
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-29.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZRichTextObject.h"

@interface SZImage : SZRichTextObject

@property (nonatomic, strong) UIImage *underlyingImage;
@property (nonatomic, strong) UIImage *displayImage;

@end
