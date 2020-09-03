//
//  SaveSecureData.h
//  OneAssistSDK
//
//  Created by Ankur Batham on 15/09/19.
//  Copyright © 2019 Ankur Batham. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaveSecureData : NSObject

#pragma mark - Getter methods
+ (NSString *)secureStringForKey:(NSString *)keyName;
+ (id)secureValueForKey:(NSString *)keyName;

#pragma mark - Setter methods
+ (void)setSecureString:(NSString*)value forKey:(NSString *)keyName;
+ (void)setSecureValue:(id)value forKey:(NSString *)keyName;

@end

NS_ASSUME_NONNULL_END
