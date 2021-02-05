//
//  Service.m
//  BookStore_DanielMoita
//
//  Created by itsector on 01/02/2021.
//

#import "Service.h"
#import "AFNetworking.h"
#include "Book.h"
static NSString *BOOK_URL = @"https://www.googleapis.com/books/v1/volumes?q=ios&maxResults=20&startIndex=0";
static NSString *API_KEY = @"AIzaSyCJj6YIzDlinwDs43uUVhXRwDnzHRo5zzM";

@implementation Service

- (void)getBookList:(void (^)(NSArray * _Nonnull))completion
{
    NSURL *url = [NSURL URLWithString:BOOK_URL];
    [self performRequest:url completion:^(NSDictionary *responseObject) {
        NSMutableArray *books = [NSMutableArray new];
        
        for (NSDictionary *object in responseObject[@"items"]) {
            Book *iOSBook = [[Book alloc] initWithTitle:object[@"volumeInfo"][@"title"] bookAuthor:object[@"volumeInfo"][@"authors"] bookDescription:object[@"volumeInfo"][@"description"] bookBuyLink:object[@"saleInfo"][@"buyLink"] bookCover:object[@"volumeInfo"][@"imageLinks"][@"thumbnail"]
                bookId:object[@"id"]];
            [books addObject:iOSBook];
        }
        completion(books);
    }];
}

- (void)performRequest:(NSURL *) url completion:(void(^)(NSDictionary *responseObject))completion
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [manager GET:url.absoluteString parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        completion(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error");
    }];
}
@end
