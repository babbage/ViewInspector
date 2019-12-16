import SwiftUI

#if !os(watchOS)

public extension ViewType {
    
    struct TabView: KnownViewType {
        public static var typePrefix: String = "TabView"
    }
}

public extension TabView {
    
    func inspect() throws -> InspectableView<ViewType.TabView> {
        return try .init(ViewInspector.Content(self))
    }
}

// MARK: - Content Extraction

extension ViewType.TabView: MultipleViewContent {
    
    public static func children(_ content: Content, envObject: Any) throws -> LazyGroup<Content> {
        let content = try Inspector.attribute(label: "content", value: content.view)
        return try Inspector.viewsInContainer(view: content)
    }
}

// MARK: - Extraction from SingleViewContent parent

public extension InspectableView where View: SingleViewContent {
    
    func tabView() throws -> InspectableView<ViewType.TabView> {
        return try .init(try child())
    }
}

// MARK: - Extraction from MultipleViewContent parent

public extension InspectableView where View: MultipleViewContent {
    
    func tabView(_ index: Int) throws -> InspectableView<ViewType.TabView> {
        return try .init(try child(at: index))
    }
}

#endif

// MARK: - Global View Modifiers

public extension InspectableView {
    
    func tag<T>(_ type: T.Type) throws -> T {
        let name = String(describing: type)
        return try modifierAttribute(
            modifierName: "TagValueTraitKey<\(name)>",
            path: "modifier|value|tagged", type: T.self, call: "tag(\(name))")
    }
    
    #if !os(watchOS)
    func tabItem() throws -> InspectableView<ViewType.ClassifiedView> {
        let rootView = try modifierAttribute(
            modifierName: "TabItemTraitKey", path: "modifier|value|some|storage|view|content",
            type: Any.self, call: "tabItem")
        return try .init(Content(rootView))
    }
    #endif
}
