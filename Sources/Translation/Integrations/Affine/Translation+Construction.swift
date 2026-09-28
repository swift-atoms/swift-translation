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
