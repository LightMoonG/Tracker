#import <Foundation/Foundation.h>

#import "AMATruncating.h"

NS_ASSUME_NONNULL_BEGIN

NS_SWIFT_NAME(DataTruncator)
@interface AMADataTruncator : NSObject <AMADataTruncating>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithMaxLength:(NSUInteger)maxLength;

@end

NS_ASSUME_NONNULL_END
