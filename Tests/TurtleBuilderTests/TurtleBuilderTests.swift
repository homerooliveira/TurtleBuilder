import XCTest
@testable import TurtleBuilder

final class TurtleBuilderTests: XCTestCase {
	func testTurtleEmpty() {
        var t = Turtle {
			pass()
			pass()
		}
		XCTAssertTrue(t.lines.count == 0)
	}

	func testTurtleNoPenDown() {
        var t = Turtle {
			forward(10)
			forward(10)
		}
		XCTAssertTrue(t.lines.count == 0)
	}

	func testTurtleWithOneLine() {
        var t = Turtle {
			penDown()
			forward(10)
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
        XCTAssertTrue(t.lines[0][0] == .init(x: 0, y: 0))
        XCTAssertTrue(t.lines[0][1] == .init(x: 0, y: 10))
	}

	func testTurtleIf() {
        var t = Turtle {
			penDown()
			if true {
				forward(10)
				pass()
			} else {
				pass()
			}
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
        XCTAssertTrue(t.lines[0][0] == .init(x: 0, y: 0))
        XCTAssertTrue(t.lines[0][1] == .init(x: 0, y: 10))
	}

	func testTurtleIf2() {
        var t = Turtle {
			penDown()
			if false {
				pass()
			} else {
				forward(10)
				pass()
			}
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
        XCTAssertTrue(t.lines[0][0] == .init(x: 0, y: 0))
        XCTAssertTrue(t.lines[0][1] == .init(x: 0, y: 10))
	}

	func testTurtleLoop1() {
        var t = Turtle {
			penDown()
			loop(10) {
				forward(10)
				pass()
			}
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
		XCTAssertTrue(t.lines.first?.count == 11)
	}

	func testTurtleLoop2() {
        var t = Turtle {
			loop(10) {
				penDown()
				left(20)
				forward(10)
				penUp()
			}
			pass()
		}
		XCTAssertTrue(t.lines.count == 10)
		for i in t.lines {
			XCTAssertTrue(i.count == 2)
		}
	}

	func testTurtleLoopWithCenter() {
        var t = Turtle {
			loop(10) {
				center()
				penDown()
				left(20)
				forward(10)
				penUp()
			}
			pass()
		}
		XCTAssertTrue(t.lines.count == 10)
		for i in t.lines {
			XCTAssertTrue(i.first?.x == 0)
			XCTAssertTrue(i.first?.y == 0)
		}
	}

	func testTurn1() {
        var t = Turtle {
			left(20)
			right(20)
			penDown()
			forward(10)
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
        XCTAssertTrue(t.lines[0][0] == .init(x: 0, y: 0))
        XCTAssertTrue(t.lines[0][1] == .init(x: 0, y: 10))
	}

	func testTurn2() {
        var t = Turtle {
		left(20)
		left(-20)
			penDown()
			forward(10)
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
        XCTAssertTrue(t.lines[0][0] == .init(x: 0, y: 0))
        XCTAssertTrue(t.lines[0][1] == .init(x: 0, y: 10))
	}

	func testMacro() {
        var t = Turtle {
			penDown()
			setMacro("forward") {
				forward(10)
				pass()
			}
			playMacro("forward")
			penUp()
		}
		XCTAssertTrue(t.lines.count == 1)
        XCTAssertTrue(t.lines[0][0] == .init(x: 0, y: 0))
        XCTAssertTrue(t.lines[0][1] == .init(x: 0, y: 10))
	}

}


