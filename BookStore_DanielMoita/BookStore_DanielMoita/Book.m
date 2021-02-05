//
//  Book.m
//  BookStore_DanielMoita
//
//  Created by itsector on 01/02/2021.
//

#import "Book.h"

@implementation Book

- (instancetype)initWithTitle:(NSString *)title bookAuthor:(NSString *)author bookDescription:(NSString *)description bookBuyLink:(NSString *)link bookCover:(NSString *)cover bookId:(nonnull NSString *)bookId {
    self = [super init];
    if (self) {
        self.bookTitle = title;
        self.bookAuthor = author;
        self.bookDescription = description;
        self.bookBuyLink = link;
        self.bookCover = cover;
        self.bookID = bookId;
    }
    return self;
}
@end
