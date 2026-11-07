public struct Translation<Displacement> {
    public let offset: Displacement
    public init(offset: Displacement) { self.offset = offset }
}

extension Translation {

    public func composed<Failure: Swift::Error>(
        with next: Self,
        using combine: (Displacement, Displacement) throws(Failure) -> Displacement
    ) throws(Failure) -> Self {
        Self(offset: try combine(offset, next.offset))
    }

    public func inverted<Failure: Swift::Error>(
        using inverse: (Displacement) throws(Failure) -> Displacement
    ) throws(Failure) -> Self {
        Self(offset: try inverse(offset))
    }
}

extension Translation: Equatable where Displacement: Equatable {}
extension Translation: Hashable where Displacement: Hashable {}
extension Translation: Sendable where Displacement: Sendable {}

extension Translation where Displacement: AdditiveArithmetic {
    public static var identity: Self { Self(offset: .zero) }
    public func composed(with next: Self) -> Self { Self(offset: offset + next.offset) }
    public func inverted() -> Self { Self(offset: .zero - offset) }
}

#if !hasFeature(Embedded)
    extension Translation: Codable where Displacement: Codable {}
#endif

extension Translation {

    public init(by displacement: Displacement) { self.init(offset: displacement) }
}

#if Affine
    public import Affine

    extension Translation {
        public func applying<Point, Failure: Swift::Error>(
            to point: Point,
            using affine: Affine<Point, Displacement, Failure>
        ) throws(Failure) -> Point {
            try affine.translated(point, by: offset)
        }

    }
#endif

#if Affine
    public import Displacement

    extension Translation {
        public init<Scalar>(dx: Scalar)
        where Displacement == Displacement::Displacement<1, Scalar> {
            self.init(by: Displacement(dx: dx))
        }

        public init<Scalar>(dx: Scalar, dy: Scalar)
        where Displacement == Displacement::Displacement<2, Scalar> {
            self.init(by: Displacement(dx: dx, dy: dy))
        }

        public init<Scalar>(dx: Scalar, dy: Scalar, dz: Scalar)
        where Displacement == Displacement::Displacement<3, Scalar> {
            self.init(by: Displacement(dx: dx, dy: dy, dz: dz))
        }

    }
#endif
