import XCTest

extension XCUIElement {
  func await(_ timeout: TimeInterval = 6.0) -> XCUIElement {
    let exists = self.exists(after: timeout, pollInterval: 0.2)
    return exists ? self: self
  }
  
  func exists(after timeout: TimeInterval, pollInterval: TimeInterval) -> Bool {
    var elapsed: TimeInterval = 0
    while elapsed < timeout {
      if waitForExistence(timeout: pollInterval) {
        return true
      }
      
      elapsed += pollInterval
    }
    
    return false
  }
}
