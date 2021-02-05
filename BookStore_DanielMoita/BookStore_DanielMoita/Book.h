//
//  Book.h
//  BookStore_DanielMoita
//
//  Created by itsector on 01/02/2021.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Book : NSObject
@property (nonatomic, strong) NSString *bookTitle;
@property (nonatomic, strong) NSString *bookAuthor;
@property (nonatomic, strong) NSString *bookDescription;
@property (nonatomic, strong) NSString *bookBuyLink;
@property (nonatomic, strong) NSString *bookCover;
@property (nonatomic, strong) NSString *bookID;

- (instancetype)initWithTitle:(NSString *)title bookAuthor:(NSString *)author bookDescription:(NSString *)description bookBuyLink:(NSURL *)url bookCover:(NSString *)cover bookId:(NSString *)bookId;
@end

NS_ASSUME_NONNULL_END
