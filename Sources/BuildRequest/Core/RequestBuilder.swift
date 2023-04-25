import Foundation

@resultBuilder
public enum RequestBuilder {
  
  public typealias Element = RequestProtocol
  
    // MARK: Builder Block
  
  @inlinable
  public static func buildBlock() -> EmptyRequest {
    EmptyRequest()
  }
  
  @inlinable
  public static func buildBlock(
    _ component: Element
  ) -> Element {
    component
  }
  
  @inlinable
  public static func buildBlock(
    _ components: Element...
  ) -> _SequenceMany {
    _SequenceMany(requests: components)
  }
  
  
    // MARK: - Builder Array
  
  @inlinable
  public static func buildArray(
    _ components: [Element])
  -> _SequenceMany {
    _SequenceMany(requests: components)
  }
  
    // MARK: - Builder Either
  
  @inlinable
  public static func buildEither(
    first component: Element
  ) -> Element {
    component
  }
  
  @inlinable
  public static func buildEither(
    second component: Element
  ) -> Element {
    component
  }
  
    // MARK: - Builder Expression
  
  @inlinable
  public static func buildExpression(
    _ expression: Element
  ) -> Element {
    expression
  }
  
    // MARK: - buildFinalResult
  
  public static func buildFinalResult(
    _ component: Element
  ) -> Element {
    component
  }
  
    // MARK: - Build Limited Availability
  
  public static func buildLimitedAvailability(
    _ component: Element
  ) -> Element {
    component
  }
  
    // MARK: - Build Optional
  
  @inlinable
  public static func buildOptional(
    _ component: Element?
  ) -> Element {
    _SequenceMany(requests: [component].compactMap({$0}))
  }
  
    // MARK: - buildPartialBlock
  
  public static func buildPartialBlock(
    first: Element
  ) -> Element {
    first
  }
  
  public static func buildPartialBlock(
    accumulated: Element,
    next: Element
  ) -> _SequenceMany {
    _SequenceMany(requests: [accumulated, next])
  }
}
