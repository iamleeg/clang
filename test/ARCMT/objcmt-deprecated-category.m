// RUN: rm -rf %t
// RUN: %clang_cc1 -objcmt-migrate-annotation -mt-migrate-directory %t %s -x objective-c -triple x86_64-apple-darwin11
// RUN: c-arcmt-test -mt-migrate-directory %t | arcmt-test -verify-transformed-files %s.result
// RUN: %clang_cc1 -triple x86_64-apple-darwin10 -fsyntax-only -x objective-c %s.result
// rdar://15337661

#define DEPRECATED  __attribute__((deprecated)) 

@interface NSArray
- (int)one;
@end

@interface NSArray (NSDraggingSourceDeprecated)

/* This method is unsafe because it could potentially cause buffer overruns. You should use -getObjects:range: instead.
*/
- (void)getObjects:(id __unsafe_unretained [])objects;
- (void)dep_getObjects:(id __unsafe_unretained [])dep_objects DEPRECATED;

@end

@interface NSArray (NSDeprecated)

/* This method is unsafe because it could potentially cause buffer overruns. You should use -getObjects:range: instead.
*/
- (void)dep_getObjects:(id __unsafe_unretained [])dep_objects DEPRECATED;
- (void)getObjects:(id __unsafe_unretained [])objects;
@property int P1;
@property int P2 DEPRECATED;
@end

@interface NSArray (DraggingSourceDeprecated)

/* This method is unsafe because it could potentially cause buffer overruns. You should use -getObjects:range: instead.
*/
- (void)getObjects:(id __unsafe_unretained [])objects;
- (void)dep_getObjects:(id __unsafe_unretained [])dep_objects DEPRECATED;
@property int P1;
@property int P2 DEPRECATED;

@end
