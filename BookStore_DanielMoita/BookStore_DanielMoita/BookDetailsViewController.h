//
//  BookDetailsViewController.h
//  BookStore_DanielMoita
//
//  Created by itsector on 03/02/2021.
//

#import <UIKit/UIKit.h>
#import "Book.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookDetailsViewController : UIViewController
@property (strong, nonatomic) Book *book;
@end

NS_ASSUME_NONNULL_END
