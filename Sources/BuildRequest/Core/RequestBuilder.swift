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
    _ component: any Element
  ) -> any Element {
    component
  }
  
  @inlinable
  public static func buildBlock(
    _ components: any Element...
  ) -> _SequenceMany {
    _SequenceMany(requests: components)
  }
  
  
    // MARK: - Builder Array
  
  @inlinable
  public static func buildArray(
    _ components: [any Element])
  -> _SequenceMany {
    _SequenceMany(requests: components)
  }
  
    // MARK: - Builder Either
  
  @inlinable
  public static func buildEither(
    first component: any Element
  ) -> any Element {
    component
  }
  
  @inlinable
  public static func buildEither(
    second component: any Element
  ) -> any Element {
    component
  }
  
    // MARK: - Builder Expression
  
  @inlinable
  public static func buildExpression(
    _ expression: any Element
  ) -> any Element {
    expression
  }
  
    // MARK: - buildFinalResult
  
  public static func buildFinalResult(
    _ component: any Element
  ) -> any Element {
    component
  }
  
    // MARK: - Build Limited Availability
  
  public static func buildLimitedAvailability(
    _ component: any Element
  ) -> any Element {
    component
  }
  
    // MARK: - Build Optional
  
  @inlinable
  public static func buildOptional(
    _ component: (any Element)?
  ) -> any Element {
    _SequenceMany(requests: [component].compactMap({$0}))
  }
  
    // MARK: - buildPartialBlock
  
  public static func buildPartialBlock(
    first: any Element
  ) -> any Element {
    first
  }
  
  public static func buildPartialBlock(
    accumulated: any Element,
    next: any Element
  ) -> _SequenceMany {
    _SequenceMany(requests: [accumulated, next])
  }
}
