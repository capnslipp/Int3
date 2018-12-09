// IntN
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.
#pragma once

#import <Foundation/NSValue.h>
#import <simd/vector_types.h>



NS_ASSUME_NONNULL_BEGIN



#pragma mark Struct Definition

struct Int3 {
	simd_int1 x, y, z;
} __attribute__((aligned(__alignof__(simd_int3))));
typedef struct Int3 Int3;



#pragma mark SIMD Conversion

/// Converts an `Int3` struct to `simd_int3` vector using zero-op/(dangerous?) C-casts.
/// (Sanity `static_assert`s in the `.mm` file do their best to ensure out struct's layout match the simd vector's.)
NS_INLINE simd_int3 Int3ToSimd(Int3 structValue) {
	return *(simd_int3 *)&structValue;
}
/// Converts an `Int3` struct from `simd_int3` vector using zero-op/(dangerous?) C-casts.
/// (Sanity `static_assert`s in the `.mm` file do their best to ensure out struct's layout match the simd vector's.)
NS_INLINE Int3 Int3FromSimd(simd_int3 simdValue) {
	return *(Int3 *)&simdValue;
}



#pragma mark `NSValue`-Wrapping

@interface NSValue (Int3Additions)

+ (NSValue *)valueWithInt3:(Int3)int3Value;

@property(nonatomic, readonly) Int3 int3Value;

@end



NS_ASSUME_NONNULL_END