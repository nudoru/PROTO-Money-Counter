//
//  NUBaseInteraction.m
//  MoneyCounter XS
//
//  Created by Matt Perkins on 9/10/12.
//
//

#import "NUBaseInteraction.h"

@implementation NUBaseInteraction

-(void)sendDebugMessage:(NSString *)text {
	NSDictionary *message = [NSDictionary dictionaryWithObjectsAndKeys:text, @"message", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"debugMessage" object:nil userInfo:message];
}

@end
