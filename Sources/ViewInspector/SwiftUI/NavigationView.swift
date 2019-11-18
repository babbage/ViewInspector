import SwiftUI

#if !os(watchOS)

public extension ViewType {
    
    struct NavigationView: KnownViewType {
        public static var typePrefix: String = "NavigationView"
    }
}

public extension NavigationView {
    
    func inspect() throws -> InspectableView<ViewType.NavigationView> {
        return try InspectableView<ViewType.NavigationView>(self)
    }
}

// MARK: - SingleViewContent

extension ViewType.NavigationView: SingleViewContent {
    
    public static func content(view: Any) throws -> Any {
        return try Inspector.attribute(path: "content", value: view)
    }
}

// MARK: - SingleViewContent

public extension InspectableView where View: SingleViewContent {
    
    func navigationView() throws -> InspectableView<ViewType.NavigationView> {
        let content = try View.content(view: view)
        return try InspectableView<ViewType.NavigationView>(content)
    }
}

// MARK: - MultipleViewContent

public extension InspectableView where View: MultipleViewContent {
    
    func navigationView(_ index: Int) throws -> InspectableView<ViewType.NavigationView> {
        let content = try contentView(at: index)
        return try InspectableView<ViewType.NavigationView>(content)
    }
}

#endif
