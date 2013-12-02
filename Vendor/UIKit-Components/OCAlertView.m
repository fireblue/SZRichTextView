//
//  OCAlertView.m
//
//  Created by Olivier Collet on 11-07-10.
//  Copyright 2011 Olivier Collet. All rights reserved.
//

#import "OCAlertView.h"

typedef void(^OCAlertViewActionBlock)(OCAlertView *alertView);

//

@interface OCAlertViewAction : NSObject {
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, copy) OCAlertViewActionBlock actionBlock;

- (id)initWithTitle:(NSString *)title actionBlock:(OCAlertViewActionBlock)actionBlock;
+ (id)actionWithTitle:(NSString *)title actionBlock:(OCAlertViewActionBlock)actionBlock;

@end

//

@interface OCAlertView () <UITextFieldDelegate>

@property (nonatomic,retain) NSMutableArray *actions;

@end

//

@implementation OCAlertView

@synthesize actions = _actions;

- (void)postInit {
	self.actions = [NSMutableArray array];
}

- (id)init {
	self = [super init];
	if (self) {
		[self postInit];
	}
	return self;
}

+ (id)alertViewWithTitle:(NSString *)title
				 message:(NSString*)message
			 cancelTitle:(NSString *)cancelTitle
			cancelAction:(void(^)(OCAlertView *alertView))cancelBlock
			confirmTitle:(NSString *)confirmTitle
		   confirmAction:(void(^)(OCAlertView *alertView))confirmBlock {
	OCAlertView *alertView = [[OCAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[alertView addButtonWithTitle:cancelTitle action:cancelBlock];
	[alertView addButtonWithTitle:confirmTitle action:confirmBlock];
	return alertView;
}

- (void)show {
	for (OCAlertViewAction *action in self.actions) {
		[super addButtonWithTitle:action.title];
	}
	self.delegate = self;
    
	[super show];
}

- (NSInteger)addButtonWithTitle:(NSString *)title {
	NSAssert(NO, @"Not allowed to use this method. You should use addButtonWithTitle:action: instead.");
	return -1;
}

#pragma mark - Buttons

- (void)addButtonWithTitle:(NSString *)title action:(void (^)(OCAlertView *alertView))actionBlock {
	if (title == nil) return;
	[self.actions addObject:[OCAlertViewAction actionWithTitle:title actionBlock:actionBlock]];
}


#pragma mark - UIAlertView delegate

- (void)willPresentAlertView:(UIAlertView *)alertView {
    if (self.alertViewStyle != UIAlertViewStyleDefault) {
        [self textFieldAtIndex:0].delegate = self;
    }
    if (self.alertViewStyle == UIAlertViewStyleLoginAndPasswordInput) {
        [self textFieldAtIndex:1].delegate = self;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex >= [self.actions count]) return;
	OCAlertViewAction *action = [self.actions objectAtIndex:buttonIndex];
	if (action.actionBlock) action.actionBlock(self);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldDismiss = NO;
    
    switch (self.alertViewStyle) {
        case UIAlertViewStyleSecureTextInput:
        case UIAlertViewStylePlainTextInput:
            shouldDismiss = YES;
            break;
            
        case UIAlertViewStyleLoginAndPasswordInput:
            shouldDismiss = ([[[self textFieldAtIndex:0] text] length] > 0) && ([[[self textFieldAtIndex:1] text] length] > 0);
            break;
            
        default:
            break;
    }
    if (shouldDismiss) {
        [self dismissWithClickedButtonIndex:1 animated:YES];
    }
    return (textField.text.length > 0);
}

@end


#pragma mark -
#pragma mark - OCAlertViewAction

@implementation OCAlertViewAction

@synthesize title = _title;
@synthesize actionBlock = _actionBlock;

- (id)initWithTitle:(NSString *)title actionBlock:(OCAlertViewActionBlock)actionBlock {
	self = [super init];
	if (self) {
		self.title = title;
		self.actionBlock = actionBlock;
	}
	return self;
}

+ (id)actionWithTitle:(NSString *)title actionBlock:(OCAlertViewActionBlock)actionBlock {
	return [[OCAlertViewAction alloc] initWithTitle:title actionBlock:actionBlock];
}

@end