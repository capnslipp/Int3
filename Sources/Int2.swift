// IntN
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.

import Foundation



/// A vector of two `Int`s.
public struct Int2
{
	public var x:Int, y:Int
	
	
	// MARK: `init`s
	
	/// Initialize to the zero vector.
	public init() {
		self.init(0)
	}
	
	/// Initialize a vector with the specified elements.
	public init(_ x:Int, _ y:Int) {
		( self.x, self.y ) = ( x, y )
	}
	
	/// Initialize a vector with the specified elements.
	public init(x:Int?=nil, y:Int?=nil) {
		self.init(x ?? 0, y ?? 0)
	}
	
	/// Initialize to a vector with all elements equal to `scalar`.
	public init(_ scalar:Int) {
		self.init(scalar, scalar)
	}
	
	/// Initialize to a vector with elements taken from `array`.
	///
	/// - Precondition: `array` must have exactly two elements.
	public init(array:[Int]) {
		precondition(array.count == 2)
		self.init(array[0], array[1])
	}
	
	/// Initialize using the given 2-element tuple.
	public init(tuple:(x:Int,y:Int)) {
		self.init(tuple.x, tuple.y)
	}
	
	/// Initialize using an `Int2`'s `x` & `y` values.
	public init(xy:Int3) {
		self.init(xy.x, xy.y)
	}
	/// Initialize using an `Int2`'s `x` & `z` values.
	public init(xz:Int3) {
		self.init(xz.x, xz.z)
	}
	/// Initialize using an `Int3`'s `y` & `z` values.
	public init(yz:Int3) {
		self.init(yz.y, yz.z)
	}
	
	
	// MARK: commonly-used “presets”
	
	public static let zero = Int2(0)
	
	public static let unitPositive = Int2(1)
	public static let unitNegative = Int2(-1)
	
	public static let unitXPositive = Int2(x: 1)
	public static let unitYPositive = Int2(y: 1)
	public static let unitXNegative = Int2(x: -1)
	public static let unitYNegative = Int2(y: -1)
	
	
	
	// MARK: `subscript`-Getter
	
	/// Access individual elements of the vector via subscript.
	public subscript(index:Int) -> Int {
		switch index {
			case 0: return self.x
			case 1: return self.y
			
			default: return Int.min // TODO: Instead, do whatever simd.int2 does.
		}
	}
	
	
	// MARK: `replace` Functionality
	
	public mutating func replace(x:Int?=nil, y:Int?=nil) {
		if let xValue = x { self.x = xValue }
		if let yValue = y { self.y = yValue }
	}
	public func replacing(x:Int?=nil, y:Int?=nil) -> Int2 {
		return Int2(
			x ?? self.x,
			y ?? self.y
		)
	}
	
	
	// MARK: `clamp` Functionality
	
	public mutating func clamp(_ range:Range<Int2>) {
		self.clamp(range.lowerBound, range.upperBound - Int2(1))
	}
	public func clamped(_ range:Range<Int2>) -> Int2 {
		return self.clamped(range.lowerBound, range.upperBound - Int2(1))
	}
	
	public mutating func clamp(_ minValue:Int2, _ maxValue:Int2) {
		self = max(minValue, min(maxValue, self))
	}
	public func clamped(_ minValue:Int2, _ maxValue:Int2) -> Int2 {
		return max(minValue, min(maxValue, self))
	}
	
	
	// MARK: `random` Functionality
	
	public static func random(min:Int2=Int2(0), max:Int2) -> Int2 {
		return Int2(
			min.x + Int(arc4random_uniform(UInt32(max.x - min.x + 1))),
			min.y + Int(arc4random_uniform(UInt32(max.y - min.y + 1)))
		)
	}
	
	
	// MARK: `asTuple` Functionality
	
	public var asTuple:(x:Int,y:Int) {
		return ( self.x, self.y )
	}
}

	
extension Int2 : CustomStringConvertible
{
	public var description:String {
		return "(\(self.x), \(self.y))"
	}
}


// MARK: Element-wise `min`/`max`

public func min(_ a:Int2, _ b:Int2) -> Int2 {
	return Int2(
		x: (b.x < a.x) ? b.x : a.x,
		y: (b.y < a.y) ? b.y : a.y
	)
}
public func min(_ a:Int2, _ b:Int2, _ c:Int2, _ rest:Int2...) -> Int2 {
	var minValue = min(min(a, b), c)
	for value in rest {
		if value.x < minValue.x { minValue.x = value.x }
		if value.y < minValue.y { minValue.y = value.y }
	}
	return minValue
}
public func max(_ a:Int2, _ b:Int2) -> Int2 {
	return Int2(
		x: (b.x > a.x) ? b.x : a.x,
		y: (b.y > a.y) ? b.y : a.y
	)
}
public func max(_ a:Int2, _ b:Int2, _ c:Int2, _ rest:Int2...) -> Int2 {
	var maxValue = max(max(a, b), c)
	for value in rest {
		if value.x > maxValue.x { maxValue.x = value.x }
		if value.y > maxValue.y { maxValue.y = value.y }
	}
	return maxValue
}


extension Int2 : ExpressibleByArrayLiteral
{
	public typealias Element = Int
	
	/// Initialize using `arrayLiteral`.
	///
	/// - Precondition: the array literal must exactly two elements.
	public init(arrayLiteral elements:Int...) {
		precondition(elements.count == 2)
		(self.x, self.y) = ( elements[0], elements[1] )
	}
}


extension Int2 : Equatable
{
	public static func ==(a:Int2, b:Int2) -> Bool {
		return a.x == b.x && a.y == b.y
	}
}


extension Int2 : Comparable
{
	public static func < (a:Int2, b:Int2) -> Bool {
		return a.x < b.x && a.y < b.y
	}
	
	public static func <= (a:Int2, b:Int2) -> Bool {
		return a.x <= b.x && a.y <= b.y
	}
	
	public static func > (a:Int2, b:Int2) -> Bool {
		return a.x > b.x && a.y > b.y
	}
	
	public static func >= (a:Int2, b:Int2) -> Bool {
		return a.x >= b.x && a.y >= b.y
	}
}


extension Int2 // pseudo-IntegerArithmetic/FixedWidthInteger
{
	private static func doComponentCalculationWithOverflow(
		_ a:Int2, _ b:Int2,
		componentCalculationMethod:(Int,Int)->(Int,overflow:Bool)
	) -> (Int2,overflow:Bool)
	{
		var result = Int2()
		var overflows = ( x: false, y: false, z: false )
		( result.x, overflows.x ) = componentCalculationMethod(a.x, b.x)
		( result.y, overflows.y ) = componentCalculationMethod(a.y, b.y)
		return (
			result,
			overflow: (overflows.x || overflows.y)
		)
	}
	
	private static func doComponentCalculationWithOverflow(
		_ a:Int2, _ b:Int2,
		componentCalculationMethod:(Int)->(Int)->(Int,overflow:Bool)
	) -> (Int2,overflow:Bool)
	{
		return doComponentCalculationWithOverflow(a, b,
			componentCalculationMethod: { (a:Int, b:Int) -> (Int,overflow:Bool) in componentCalculationMethod(a)(b) }
		)
	}
	
	
	public static func + (a:Int2, b:Int2) -> Int2 {
		return self.init(x: (a.x + b.x), y: (a.y + b.y))
	}
	public static func += (v:inout Int2, o:Int2) {
		v = v + o
	}
	
	#if swift(>=4.0)
		public func addingReportingOverflow(_ other:Int2) -> (partialValue:Int2,overflow:Bool) {
			return Int2.doComponentCalculationWithOverflow(self, other, componentCalculationMethod: Int.addingReportingOverflow)
		}
		
		public func unsafeAdding(_ other:Int2) -> Int2 {
			return self.addingReportingOverflow(other).partialValue
		}
	#else
		public static func addWithOverflow(_ a:Int2, _ b:Int2) -> (Int2,overflow:Bool) {
			return doComponentCalculationWithOverflow(a, b, componentCalculationMethod: Int.addWithOverflow)
		}
	#endif
	
	
	public static func - (a:Int2, b:Int2) -> Int2 {
		return Int2(a.x - b.x, a.y - b.y)
	}
	public static func -= (v:inout Int2, o:Int2) {
		v = v - o
	}
	
	#if swift(>=4.0)
		public func subtractingReportingOverflow(_ other:Int2) -> (partialValue:Int2,overflow:Bool) {
			return Int2.doComponentCalculationWithOverflow(self, other, componentCalculationMethod: Int.subtractingReportingOverflow)
		}
		
		public func unsafeSubstracting(_ other:Int2) -> Int2 {
			return self.subtractingReportingOverflow(other).partialValue
		}
	#else
		public static func subtractWithOverflow(_ a:Int2, _ b:Int2) -> (Int2,overflow:Bool) {
			return doComponentCalculationWithOverflow(a, b, componentCalculationMethod: Int.subtractWithOverflow)
		}
	#endif
	
	
	public static func * (a:Int2, b:Int2) -> Int2 {
		return Int2(a.x * b.x, a.y * b.y)
	}
	public static func *= (v:inout Int2, o:Int2) {
		v = v * o
	}
	
	#if swift(>=4.0)
		public func multipliedReportingOverflow(by other:Int2) -> (partialValue:Int2,overflow:Bool) {
			return Int2.doComponentCalculationWithOverflow(self, other, componentCalculationMethod: Int.multipliedReportingOverflow(by:))
		}
		
		public func unsafeMultiplied(by other:Int2) -> Int2 {
			return self.multipliedReportingOverflow(by: other).partialValue
		}
	#else
		public static func multiplyWithOverflow(_ a:Int2, _ b:Int2) -> (Int2,overflow:Bool) {
			return doComponentCalculationWithOverflow(a, b, componentCalculationMethod: Int.multiplyWithOverflow)
		}
	#endif
	
	
	public static func / (a:Int2, b:Int2) -> Int2 {
		return Int2(a.x / b.x, a.y / b.y)
	}
	public static func /= (v:inout Int2, o:Int2) {
		v = v / o
	}
	
	#if swift(>=4.0)
		public func dividedReportingOverflow(by other:Int2) -> (partialValue:Int2,overflow:Bool) {
			return Int2.doComponentCalculationWithOverflow(self, other, componentCalculationMethod: Int.dividedReportingOverflow(by:))
		}
		
		public func unsafeDivided(by other:Int2) -> Int2 {
			return self.dividedReportingOverflow(by: other).partialValue
		}
	#else
		public static func divideWithOverflow(_ a:Int2, _ b:Int2) -> (Int2,overflow:Bool) {
			return doComponentCalculationWithOverflow(a, b, componentCalculationMethod: Int.divideWithOverflow)
		}
	#endif
	
	
	public static func % (a:Int2, b:Int2) -> Int2 {
		return Int2(a.x % b.x, a.y % b.y)
	}
	public static func %= (v:inout Int2, o:Int2) {
		v = v % o
	}
	
	#if swift(>=4.0)
		public func remainderReportingOverflow(dividingBy other:Int2) -> (partialValue:Int2,overflow:Bool) {
			return Int2.doComponentCalculationWithOverflow(self, other, componentCalculationMethod: Int.remainderReportingOverflow(dividingBy:))
		}
	#else
		public static func remainderWithOverflow(_ a:Int2, _ b:Int2) -> (Int2,overflow:Bool) {
			return doComponentCalculationWithOverflow(a, b, componentCalculationMethod: Int.remainderWithOverflow)
		}
	#endif
	
	
	public static prefix func - (v:Int2) -> Int2 {
		return Int2(0) - v
	}
}


extension Int2 : Hashable
{
	private static let _hashingLargePrimes:[UInt] = [ 982_917_223, 3_572_352_083 ]
	
	public var hashValue:Int {
		let uintHashValue = [ self.x, self.y ].enumerated().reduce(UInt(0)){ (hashValue, element:(index:Int,value:Int)) in
			let elementHash = UInt(bitPattern: element.value) &* Int2._hashingLargePrimes[element.index]
			return hashValue &+ elementHash
		}
		return Int(bitPattern: uintHashValue)
	}
}


#if !SWIFT_PACKAGE
extension Int2 : _ObjectiveCBridgeable
{
	public func _bridgeToObjectiveC() -> NSValue {
		var myself = self
		return NSValue(bytes: &myself, objCType: Int2_CStruct_objCTypeEncoding)
	}
	
	public static func _forceBridgeFromObjectiveC(_ source:NSValue, result:inout Int2?) {
		precondition(strcmp(source.objCType, Int2_CStruct_objCTypeEncoding) == 0, "NSValue does not contain the right type to bridge to Int2")
		result = Int2()
		source.getValue(&result!)
	}
	
	public static func _conditionallyBridgeFromObjectiveC(_ source:NSValue, result:inout Int2?) -> Bool {
		if strcmp(source.objCType, Int2_CStruct_objCTypeEncoding) != 0 {
			result = nil
			return false
		}
		result = Int2()
		source.getValue(&result!)
		return true
	}
	
	public static func _unconditionallyBridgeFromObjectiveC(_ source:NSValue?) -> Int2 {
		let unwrappedSource = source!
		precondition(strcmp(unwrappedSource.objCType, Int2_CStruct_objCTypeEncoding) == 0, "NSValue does not contain the right type to bridge to Int2")
		var result = Int2()
		unwrappedSource.getValue(&result)
		return result
	}
}
#endif // !SWIFT_PACKAGE
