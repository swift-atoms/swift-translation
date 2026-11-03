# swift-translation

Use this package when you need the operation "move by this offset" as a value that can be composed, inverted and applied, rather than the offset itself. Start from `Translation<Displacement>`, which stores one offset of any type, for example a swift-displacement `Displacement<3, Int>` or a `Swift.Duration`. For the offset as a plain value, use swift-displacement; for applying a translation to a point, enable the `Affine` trait, which brings in swift-affine and swift-displacement.

## Laws

- Composition applies `self` first and `next` second: the closure form passes `(self.offset, next.offset)` in that order to `combine`, and the `AdditiveArithmetic` form returns `offset + next.offset`.
- When the offset is `AdditiveArithmetic`, `identity` has offset `.zero` and `inverted()` has offset `.zero - offset`, so a translation composed with its inverse is `identity` and composing with `identity` leaves a translation unchanged.
- Applying a translation to a point does no arithmetic of its own: it hands the offset to the `Affine` witness's `translated(_:by:)` and rethrows that witness's failure.
