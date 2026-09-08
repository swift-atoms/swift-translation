import Displacement
import Testing
import Translation

@Suite struct `Translation construction names the displacement it applies` {
    @Test func `A translation is constructed by its displacement`() {
        let delta = Displacement(dx: 3, dy: -2, dz: 1)
        let translation = Translation(by: delta)
        let typed: Translation<Displacement<3, Int>> = translation

        #expect(typed.offset == delta)
    }

    @Test func `A contextual displacement needs no repeated type name`() {
        let translation: Translation<Displacement<2, Double>> =
            .init(by: .init(dx: 10, dy: -5))

        #expect(translation.offset.dx == 10.0)
        #expect(translation.offset.dy == -5.0)
    }

    @Test func `Temporal translations reuse native duration syntax`() {
        let delay: Translation<Swift.Duration> = .init(by: .seconds(3))

        #expect(delay.offset == .seconds(3))
        #expect(delay.composed(with: .init(by: .seconds(2))).offset == .seconds(5))
        #expect(delay.inverted().offset == .seconds(-3))
        #expect(delay.composed(with: .identity) == delay)
    }
}
