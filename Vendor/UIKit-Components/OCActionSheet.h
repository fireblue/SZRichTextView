//
//  OCActionSheet.h
//
//  Created by Olivier Collet on 11-09-28.
//  Copyright (c) 2011 Olivier Collet. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OCActionSheetDelegate <UIActionSheetDelegate>
@end


@interface OCActionSheet : UIActionSheet <UIActionSheetDelegate>

@property (nonatomic, weak) id<OCActionSheetDelegate> actionSheetDelegate;

+ (id)actionSheetWithTitle:(NSString *)title;

- (void)addButtonWithTitle:(NSString *)title action:(void (^)(void))actionBlock;
- (void)addCancelButtonWithTitle:(NSString *)title action:(void (^)(void))actionBlock;
- (void)addDestructiveButtonWithTitle:(NSString *)title action:(void (^)(void))actionBlock;

@end
