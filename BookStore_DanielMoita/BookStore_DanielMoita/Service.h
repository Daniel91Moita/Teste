//
//  Service.h
//  BookStore_DanielMoita
//
//  Created by itsector on 01/02/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Service : NSObject

- (void)getBookList:(void (^) (NSArray *object))completion;

@end

NS_ASSUME_NONNULL_END
