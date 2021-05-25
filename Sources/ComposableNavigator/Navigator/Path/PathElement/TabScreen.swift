public struct TabScreen: Hashable {
  public struct Tab: Hashable {
    let head: NavigationPathElement
    let tail: NavigationPath

    var id: ScreenID { head.id }
    func ids() -> Set<ScreenID> {
      tail.ids().union([id])
    }
  }

  public let id: ScreenID
  public let activeTab: Tab
  public let inactiveTabs: Set<Tab>

  public func ids() -> Set<ScreenID> {
    inactiveTabs.reduce(
      Set<ScreenID>(activeTab.ids().union([id])),
      { acc, tab in
        acc.union(tab.ids())
      }
    )
  }

  public func contents() -> Set<AnyScreen> {
    inactiveTabs.reduce(
      Set<AnyScreen>(activeTab.head.contents()).union(activeTab.tail.contents()),
      { acc, tab in
        acc.union(tab.tail.contents().union(tab.head.contents()))
      }
    )
  }
}
