//
//  OCBarButtonItem.m
//
//  Created by Olivier Collet on 11-10-24.
//  Copyright (c) 2011 Olivier Collet. All rights reserved.
//

#import "OCBarButtonItem.h"

@interface OCBarButtonItem ()

@property (copy, nonatomic) void (^buttonActionBlock)(void);

@end

@implementation OCBarButtonItem
@synthesize buttonActionBlock;

+ (id)itemWithBarButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void (^)(void))actionBlock {
	OCBarButtonItem *button = [[OCBarButtonItem alloc] initWithBarButtonSystemItem:systemItem target:nil action:nil];
	[button setActionBlock:actionBlock];
	return button;
}

+ (id)itemWithCustomView:(UIView *)customView actionBlock:(void (^)(void))actionBlock {
	OCBarButtonItem *button = [[OCBarButtonItem alloc] initWithCustomView:customView];
	[button setActionBlock:actionBlock];
	return button;
}

+ (id)itemWithImage:(UIImage *)image style:(UIBarButtonItemStyle)style actionBlock:(void (^)(void))actionBlock {
	OCBarButtonItem *button = [[OCBarButtonItem alloc] initWithImage:image style:style target:nil action:nil];
	[button setActionBlock:actionBlock];
	return button;
}

+ (id)itemWithImage:(UIImage *)image landscapeImagePhone:(UIImage *)landscapeImagePhone style:(UIBarButtonItemStyle)style actionBlock:(void (^)(void))actionBlock {
	OCBarButtonItem *button = [[OCBarButtonItem alloc] initWithImage:image landscapeImagePhone:landscapeImagePhone style:style target:nil action:nil];
	[button setActionBlock:actionBlock];
	return button;	
}

+ (id)itemWithTitle:(NSString *)title style:(UIBarButtonItemStyle)style actionBlock:(void (^)(void))actionBlock {
	OCBarButtonItem *button = [[OCBarButtonItem alloc] initWithTitle:title style:style target:nil action:nil];
	[button setActionBlock:actionBlock];
	return button;
}

//

- (void)setActionBlock:(void (^)(void))actionBlock {
	self.buttonActionBlock = actionBlock;
	[self setTarget:self];
	[self setAction:@selector(executeActionBlock)];
}

- (void)executeActionBlock {
	if (self.buttonActionBlock) {
		self.buttonActionBlock();
	}
}

@end
