import Displacement
import Testing
import Translation
import Vector

@Suite struct `Translations preserve composition and inversion` {
    @Test func `Translation composition and inversion are independent of dimension`() {
        let first = Translation(offset: Displacement(components: Vector<3, Int>([1, 2, 3])))
        let second = Translation(offset: Displacement(components: Vector<3, Int>([4, 5, 6])))
        #expect(first.composed(with: second).offset.components == Vector([5, 7, 9]))
        #expect(first.composed(with: first.inverted()) == .identity)
        #expect(first.composed(with: .identity) == first)
    }
    @Test func `Translations reuse native durations`() {
        let operation = Translation(offset: Swift.Duration.seconds(3))
        #expect(operation.inverted().offset == .seconds(-3))
    }
}
