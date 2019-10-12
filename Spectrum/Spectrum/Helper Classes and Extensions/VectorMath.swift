//
//  VectorMath.swift
//  VectorMath
//
//  Version 0.4.0
//
//  Created by Nick Lockwood on 24/11/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//
//  Distributed under the permissive MIT License
//  Get the latest version from here:
//
//  https://github.com/nicklockwood/VectorMath
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

//this is andy, i have added a section in the middle with my own code to make gamekit playnice

import Foundation
import GameKit

// MARK: Types

public typealias Scalar = Float

public struct Vector2: Hashable {
    public var x: Scalar
    public var y: Scalar
}

public struct Vector3: Hashable {
    public var x: Scalar
    public var y: Scalar
    public var z: Scalar
}


// MARK: Scalar

public extension Scalar {
    static let halfPi = pi / 2
    static let quarterPi = pi / 4
    static let twoPi = pi * 2
    static let degreesPerRadian = 180 / pi
    static let radiansPerDegree = pi / 180
    static let epsilon: Scalar = 0.0001

    static func ~= (lhs: Scalar, rhs: Scalar) -> Bool {
        return Swift.abs(lhs - rhs) < .epsilon
    }

    fileprivate var sign: Scalar {
        return self > 0 ? 1 : -1
    }
}
//andy's extensions to Vector2:P{

public extension CGVector{
    init(_ vector2:Vector2){
        self.init(dx: CGFloat(vector2.x),dy: CGFloat(vector2.y))
    }
}

public extension Vector2{
    init(_ p:CGPoint){
        self.init( x:Scalar(p.x), y: Scalar(p.y) )
    }
    init(_ v:CGVector){
        self.init( x: Scalar(v.dx), y: Scalar(v.dy))
    }
    func slowedTo(_ s:Scalar)->Vector2{
        let length = self.length
        if ( length > Scalar(s)){
            let new = self.normalized()*s
            return new
        }
        return self
    }
}



// MARK: Vector2

public extension Vector2 {
    static let zero = Vector2(0, 0)
    static let x = Vector2(1, 0)
    static let y = Vector2(0, 1)

    var lengthSquared: Scalar {
        return x * x + y * y
    }

    var length: Scalar {
        return sqrt(lengthSquared)
    }

    var inverse: Vector2 {
        return -self
    }

    init(_ x: Scalar, _ y: Scalar) {
        self.init(x: x, y: y)
    }

    init(_ v: [Scalar]) {
        assert(v.count == 2, "array must contain 2 elements, contained \(v.count)")
        self.init(v[0], v[1])
    }

    func toArray() -> [Scalar] {
        return [x, y]
    }

    func dot(_ v: Vector2) -> Scalar {
        return x * v.x + y * v.y
    }

    func cross(_ v: Vector2) -> Scalar {
        return x * v.y - y * v.x
    }

    func normalized() -> Vector2 {
        let lengthSquared = self.lengthSquared
        if lengthSquared ~= 0 || lengthSquared ~= 1 {
            return self
        }
        return self / sqrt(lengthSquared)
    }

    func rotated(by radians: Scalar) -> Vector2 {
        let cs = cos(radians)
        let sn = sin(radians)
        return Vector2(x * cs - y * sn, x * sn + y * cs)
    }

    func rotated(by radians: Scalar, around pivot: Vector2) -> Vector2 {
        return (self - pivot).rotated(by: radians) + pivot
    }

    func angle(with v: Vector2) -> Scalar {
        if self == v {
            return 0
        }

        let t1 = normalized()
        let t2 = v.normalized()
        let cross = t1.cross(t2)
        let dot = max(-1, min(1, t1.dot(t2)))

        return atan2(cross, dot)
    }

    func interpolated(with v: Vector2, by t: Scalar) -> Vector2 {
        return self + (v - self) * t
    }

    static prefix func - (v: Vector2) -> Vector2 {
        return Vector2(-v.x, -v.y)
    }

    static func + (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x + rhs.x, lhs.y + rhs.y)
    }

    static func - (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x - rhs.x, lhs.y - rhs.y)
    }

    static func * (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x * rhs.x, lhs.y * rhs.y)
    }

    static func * (lhs: Vector2, rhs: Scalar) -> Vector2 {
        return Vector2(lhs.x * rhs, lhs.y * rhs)
    }

//    static func * (lhs: Vector2, rhs: Matrix3) -> Vector2 {
//        return Vector2(
//            lhs.x * rhs.m11 + lhs.y * rhs.m21 + rhs.m31,
//            lhs.x * rhs.m12 + lhs.y * rhs.m22 + rhs.m32
//        )
//    }

    static func / (lhs: Vector2, rhs: Vector2) -> Vector2 {
        return Vector2(lhs.x / rhs.x, lhs.y / rhs.y)
    }

    static func / (lhs: Vector2, rhs: Scalar) -> Vector2 {
        return Vector2(lhs.x / rhs, lhs.y / rhs)
    }

    static func ~= (lhs: Vector2, rhs: Vector2) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y
    }
}


