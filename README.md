# Translation

Translation<Displacement> stores a displacement as a translation value.
It does not select a point representation or depend on Affine.

AdditiveArithmetic displacements support identity, composition, and inversion
using native arithmetic. Typed-throwing closure overloads support checked or
domain-specific composition and inversion. A bounded minimum signed displacement
may have no representable inverse.

Equality, hashing, sendability, and encoding are conditional.
Temporal translations reuse Swift.Duration directly; spatial translations can use
Displacement<N, Scalar>.

Import Point_Affine from swift-point-affine to apply a translation to a point using
an explicit Affine<Point, Displacement, Failure> relationship.

## Construction

```swift
import Translation

let delay: Translation<Swift.Duration> = .init(by: .seconds(3))
let combined = delay.composed(with: .init(by: .seconds(2)))
```

init(by:) delegates to the existing init(offset:) without changing storage.
Spatial shorthand such as Translation(dx: 3, dy: -2, dz: 1) is supplied by
Point_Affine, keeping this atom independent of spatial representations.
