// Vuckt
// @author: Slipp Douglas Thompson
// @license: Public Domain per The Unlicense.  See accompanying LICENSE file or <http://unlicense.org/>.

import XCTest
import Vuckt
import simd.vector_types



class VucktTests : XCTestCase
{
	let _int2TestValues:[[Int32]] = [
		[ 0, 0 ],
		[ 1, 2 ],
		[ Int32.min, Int32.max ],
		[ -179_424_720, 2_038_074_496 ],
	]
	let _int3TestValues:[[Int32]] = [
		[ 0, 0, 0 ],
		[ 1, 2, 3 ],
		[ Int32.min, Int32.max, Int32.min ],
		[ -179_424_720, 2_038_074_496, -982_450_304 ],
	]
	let _int4TestValues:[[Int32]] = [
		[ 0, 0, 0, 0 ],
		[ 1, 2, 3, 4 ],
		[ Int32.min, Int32.max, Int32.min, Int32.max ],
		[ -179_424_720, 2_038_074_496, -982_450_304, 454_923_712 ],
	]
	let _float2TestValues:[[Float]] = [
		[ 0, 0 ],
		[ 1, 2 ],
		[ Float.infinity, Float.leastNonzeroMagnitude ],
		[ -179_424_720, 2_038_074_496 ],
	]
	let _float3TestValues:[[Float]] = [
		[ 0, 0, 0 ],
		[ 1, 2, 3 ],
		[ Float.infinity, Float.leastNonzeroMagnitude, Float.greatestFiniteMagnitude ],
		[ -179_424_720, 2_038_074_496, -982_450_304 ],
	]
	let _float4TestValues:[[Float]] = [
		[ 0, 0, 0, 0 ],
		[ 1, 2, 3, 4 ],
		[ Float.infinity, Float.leastNonzeroMagnitude, Float.greatestFiniteMagnitude, Float.leastNormalMagnitude ],
		[ -179_424_720, 2_038_074_496, -982_450_304, 454_923_712 ],
	]
	
	
	override func setUp()
	{
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown()
	{
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	
	
	#if !NO_OBJC_BRIDGE
	func testNSValueRoundtripping()
	{
		_int2TestValues.map(Int2.init).forEach{
			let nsValue = NSValue(int2: $0)
			let value = nsValue.int2Value
			XCTAssertEqual($0, value)
		}
		
		_int3TestValues.map(Int3.init).forEach{
			let nsValue = NSValue(int3: $0)
			let value = nsValue.int3Value
			XCTAssertEqual($0, value)
		}
		
		_int4TestValues.map(Int4.init).forEach{
			let nsValue = NSValue(int4: $0)
			let value = nsValue.int4Value
			XCTAssertEqual($0, value)
		}
		
		_float2TestValues.map(Float2.init).forEach{
			let nsValue = NSValue(float2: $0)
			let value = nsValue.float2Value
			XCTAssertEqual($0, value)
		}
		
		_float3TestValues.map(Float3.init).forEach{
			let nsValue = NSValue(float3: $0)
			let value = nsValue.float3Value
			XCTAssertEqual($0, value)
		}
		
		_float4TestValues.map(Float4.init).forEach{
			let nsValue = NSValue(float4: $0)
			let value = nsValue.float4Value
			XCTAssertEqual($0, value)
		}
	}
	#endif
	
	func testSIMDRoundtripping()
	{
		_int2TestValues.map(Int2.init).forEach{
			let simdValue = $0.simdValue
			let value = Int2(simdValue)
			XCTAssertEqual($0, value)
		}
		
		_int3TestValues.map(Int3.init).forEach{
			let simdValue = $0.simdValue
			let value = Int3(simdValue)
			XCTAssertEqual($0, value)
		}
		
		_int4TestValues.map(Int4.init).forEach{
			let simdValue = $0.simdValue
			let value = Int4(simdValue)
			XCTAssertEqual($0, value)
		}
		
		_float2TestValues.map(Float2.init).forEach{
			let simdValue = $0.simdValue
			let value = Float2(simdValue)
			XCTAssertEqual($0, value)
		}
		
		_float3TestValues.map(Float3.init).forEach{
			let simdValue = $0.simdValue
			let value = Float3(simdValue)
			XCTAssertEqual($0, value)
		}
		
		_float4TestValues.map(Float4.init).forEach{
			let simdValue = $0.simdValue
			let value = Float4(simdValue)
			XCTAssertEqual($0, value)
		}
	}
	
	func testEquality()
	{
		XCTAssertTrue(
			Int2(1, 2) == Int2(1, 2)
		)
		XCTAssertTrue(
			Int3(1, 2, 3) == Int3(1, 2, 3)
		)
		XCTAssertTrue(
			Int4(1, 2, 3, 4) == Int4(1, 2, 3, 4)
		)
		XCTAssertTrue(
			Float2(1, 2) == Float2(1, 2)
		)
		XCTAssertTrue(
			Float3(1, 2, 3) == Float3(1, 2, 3)
		)
		XCTAssertTrue(
			Float4(1, 2, 3, 4) == Float4(1, 2, 3, 4)
		)
		
		XCTAssertTrue(
			Int2(1, 2) != Int2(10, 20)
		)
		XCTAssertTrue(
			Int3(1, 2, 3) != Int3(10, 20, 30)
		)
		XCTAssertTrue(
			Int4(1, 2, 3, 4) != Int4(10, 20, 30, 40)
		)
		XCTAssertTrue(
			Float2(1, 2) != Float2(10, 20)
		)
		XCTAssertTrue(
			Float3(1, 2, 3) != Float3(10, 20, 30)
		)
		XCTAssertTrue(
			Float4(1, 2, 3, 4) != Float4(10, 20, 30, 40)
		)
	}
	
	func testAddMath()
	{
		XCTAssertEqual(
			Int2(1, 2) + Int2(-10, -20),
			Int2(simd_int2(1, 2) &+ simd_int2(-10, -20))
		)
		XCTAssertEqual(
			Int3(1, 2, 3) + Int3(-10, -20, -30),
			Int3(simd_int3(1, 2, 3) &+ simd_int3(-10, -20, -30))
		)
		XCTAssertEqual(
			Int4(1, 2, 3, 4) + Int4(-10, -20, -30, -40),
			Int4(simd_int4(1, 2, 3, 4) &+ simd_int4(-10, -20, -30, -40))
		)
		
		XCTAssertEqual(
			Float2(1, 2) + Float2(-10, -20),
			Float2(simd_float2(1, 2) + simd_float2(-10, -20))
		)
		XCTAssertEqual(
			Float3(1, 2, 3) + Float3(-10, -20, -30),
			Float3(simd_float3(1, 2, 3) + simd_float3(-10, -20, -30))
		)
		XCTAssertEqual(
			Float4(1, 2, 3, 4) + Float4(-10, -20, -30, -40),
			Float4(simd_float4(1, 2, 3, 4) + simd_float4(-10, -20, -30, -40))
		)
	}
	
	func testSubtractMath()
	{
		XCTAssertEqual(
			Int2(1, 2) - Int2(-10, -20),
			Int2(simd_int2(1, 2) &- simd_int2(-10, -20))
		)
		XCTAssertEqual(
			Int3(1, 2, 3) - Int3(-10, -20, -30),
			Int3(simd_int3(1, 2, 3) &- simd_int3(-10, -20, -30))
		)
		XCTAssertEqual(
			Int4(1, 2, 3, 4) - Int4(-10, -20, -30, -40),
			Int4(simd_int4(1, 2, 3, 4) &- simd_int4(-10, -20, -30, -40))
		)
		
		XCTAssertEqual(
			Float2(1, 2) - Float2(-10, -20),
			Float2(simd_float2(1, 2) - simd_float2(-10, -20))
		)
		XCTAssertEqual(
			Float3(1, 2, 3) - Float3(-10, -20, -30),
			Float3(simd_float3(1, 2, 3) - simd_float3(-10, -20, -30))
		)
		XCTAssertEqual(
			Float4(1, 2, 3, 4) - Float4(-10, -20, -30, -40),
			Float4(simd_float4(1, 2, 3, 4) - simd_float4(-10, -20, -30, -40))
		)
	}
	
	func testMultiplyMath()
	{
		XCTAssertEqual(
			Int2(1, 2) * Int2(-10, -20),
			Int2(simd_int2(1, 2) &* simd_int2(-10, -20))
		)
		XCTAssertEqual(
			Int3(1, 2, 3) * Int3(-10, -20, -30),
			Int3(simd_int3(1, 2, 3) &* simd_int3(-10, -20, -30))
		)
		XCTAssertEqual(
			Int4(1, 2, 3, 4) * Int4(-10, -20, -30, -40),
			Int4(simd_int4(1, 2, 3, 4) &* simd_int4(-10, -20, -30, -40))
		)
		
		XCTAssertEqual(
			Float2(1, 2) * Float2(-10, -20),
			Float2(simd_float2(1, 2) * simd_float2(-10, -20))
		)
		XCTAssertEqual(
			Float3(1, 2, 3) * Float3(-10, -20, -30),
			Float3(simd_float3(1, 2, 3) * simd_float3(-10, -20, -30))
		)
		XCTAssertEqual(
			Float4(1, 2, 3, 4) * Float4(-10, -20, -30, -40),
			Float4(simd_float4(1, 2, 3, 4) * simd_float4(-10, -20, -30, -40))
		)
	}
	
	func testDivideMath()
	{
		XCTAssertEqual(
			Int2(-10, -20) / Int2(2, 3),
			Int2(simd_int2(-10, -20) / simd_int2(2, 3))
		)
		XCTAssertEqual(
			Int3(-10, -20, -30) / Int3(2, 3, 4),
			Int3(simd_int3(-10, -20, -30) / simd_int3(2, 3, 4))
		)
		XCTAssertEqual(
			Int4(-10, -20, -30, -40) / Int4(2, 3, 4, 5),
			Int4(simd_int4(-10, -20, -30, -40) / simd_int4(2, 3, 4, 5))
		)
		
		XCTAssertEqual(
			Float2(-10, -20) / Float2(2, 3),
			Float2(simd_float2(-10, -20) / simd_float2(2, 3))
		)
		XCTAssertEqual(
			Float3(-10, -20, -30) / Float3(2, 3, 4),
			Float3(simd_float3(-10, -20, -30) / simd_float3(2, 3, 4))
		)
		XCTAssertEqual(
			Float4(-10, -20, -30, -40) / Float4(2, 3, 4, 5),
			Float4(simd_float4(-10, -20, -30, -40) / simd_float4(2, 3, 4, 5))
		)
	}
	
	func testModulusMath()
	{
		XCTAssertEqual(
			Int2(-10, -20) % Int2(2, 3),
			Int2(simd_int2(-10, -20) % simd_int2(2, 3))
		)
		XCTAssertEqual(
			Int3(-10, -20, -30) % Int3(2, 3, 4),
			Int3(simd_int3(-10, -20, -30) % simd_int3(2, 3, 4))
		)
		XCTAssertEqual(
			Int4(-10, -20, -30, -40) % Int4(2, 3, 4, 5),
			Int4(simd_int4(-10, -20, -30, -40) % simd_int4(2, 3, 4, 5))
		)
		
		XCTAssertEqual(
			Float2(-10, -20) % Float2(2, 3),
			Float2(0, -2)
		)
		XCTAssertEqual(
			Float3(-10, -20, -30) % Float3(2, 3, 4),
			Float3(0, -2, -2)
		)
		XCTAssertEqual(
			Float4(-10, -20, -30, -40) % Float4(2, 3, 4, 5),
			Float4(0, -2, -2, 0)
		)
	}
	
	func testNegationMath()
	{
		XCTAssertEqual(
			-Int2(1, 2),
			Int2(0 &- simd_int2(1, 2))
		)
		XCTAssertEqual(
			-Int3(1, 2, 3),
			Int3(0 &- simd_int3(1, 2, 3))
		)
		XCTAssertEqual(
			-Int4(1, 2, 3, 4),
			Int4(0 &- simd_int4(1, 2, 3, 4))
		)
		
		XCTAssertEqual(
			-Float2(1, 2),
			Float2(-simd_float2(1, 2))
		)
		XCTAssertEqual(
			-Float3(1, 2, 3),
			Float3(-simd_float3(1, 2, 3))
		)
		XCTAssertEqual(
			-Float4(1, 2, 3, 4),
			Float4(-simd_float4(1, 2, 3, 4))
		)
	}
	
	func testPerformanceExample()
	{
		// This is an example of a performance test case.
		self.measure {
			// Put the code you want to measure the time of here.
		}
	}

}
