//
//  SZImageCollectionViewCell.m
//  RichTextViewTest
//
//  Created by Zongxuan Su on 13-11-16.
//  Copyright (c) 2013年 SZX. All rights reserved.
//

#import "SZImageCollectionViewCell.h"
#import "SZImage.h"
#import "UIImage+Resize.h"
#import "OCActionSheet.h"

@interface SZImageCollectionViewCell ()

@property (nonatomic, weak) SZImage *richTextObject;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

@end

@implementation SZImageCollectionViewCell

@synthesize richTextObject = _richTextObject;

- (void)setRichTextObject:(SZImage *)richTextObject
{
    CGFloat originalWidth = richTextObject.underlyingImage.size.width;
    CGFloat originalHeight = richTextObject.underlyingImage.size.height;
    CGFloat scaledWidth = self.frame.size.width;
    CGFloat scaledHeight = scaledWidth / originalWidth *originalHeight;
    richTextObject.size = CGSizeMake(scaledWidth, scaledHeight);
    self.imageView.frame = CGRectMake(0, 0, scaledWidth, scaledHeight);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        richTextObject.displayImage = [richTextObject.underlyingImage resizedImage:CGSizeMake(richTextObject.size.width*2, richTextObject.size.height*2) interpolationQuality:kCGInterpolationDefault];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = richTextObject.displayImage;
        });
    });
    
    _richTextObject = richTextObject;
}

- (IBAction)deleteFromRichTextView:(id)sender
{
    OCActionSheet *actionSheet = [[OCActionSheet alloc] init];
    [actionSheet addDestructiveButtonWithTitle:@"删除" action:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.parent deleteImage:self.richTextObject];
        });
    }];
    [actionSheet addCancelButtonWithTitle:@"取消" action:^{
        
    }];
    [actionSheet showInView:self.parent.view];
}

@end
