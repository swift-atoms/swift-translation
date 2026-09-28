#if Affine
public import Affine

extension Translation {
    public func applying<Point, Failure: Swift.Error>(
        to point: Point, using affine: Affine<Point, Displacement, Failure>
    ) throws(Failure) -> Point {
        try affine.translated(point, by: offset)
    }

}
#endif
