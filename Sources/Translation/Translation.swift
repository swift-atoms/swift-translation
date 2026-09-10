/// A displacement packaged as an operation. An integration layer supplies
/// the relationship to the points on which the operation acts.
public struct Translation<Displacement> {
    public let offset: Displacement
    public init(offset: Displacement) { self.offset = offset }

    public func composed<Failure: Swift.Error>(
        with next: Self,
        using combine: (Displacement, Displacement) throws(Failure) -> Displacement
    ) throws(Failure) -> Self {
        Self(offset: try combine(offset, next.offset))
    }

    public func inverted<Failure: Swift.Error>(
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
    /// Constructs a translation by the supplied displacement.
    public init(by displacement: Displacement) { self.init(offset: displacement) }
}
