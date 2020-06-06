#import <Foundation/Foundation.h>

@interface NSObject (Extension)
- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;
@end
