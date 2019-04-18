
import HTMLKit
import Vapor


struct AllCategoriesTemplate: ContextualTemplate {

    struct Context {
        let categories: [Category]
        let base: BaseTemplate.Context

        init(categories: [Category], req: Request) throws {
            self.categories = categories
            self.base = try .init(title: "All Categories", req: req)
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:

                h1.child("All Categories"),

                runtimeIf(
                    \.categories.count > 0,

                    table.class("table table-bordered table-hover").child(
                        thead.class("thead-light").child(
                            tr.child(
                                th.child("Name")
                            )
                        ),
                        tbody.child(
                            // All categories
                            forEach(in:     \.categories,
                                    render: CategoryRow()
                            )
                        )
                    )
                ).else(
                    h2.child(
                        "There aren't any categories yet!"
                    )
                )
            ),
        withPath: \Context.base)
    }


    // MARK: - Sub views

    struct CategoryRow: ContextualTemplate {

        typealias Context = Category

        func build() -> CompiledTemplate {
            return
                tr.child(
                    td.child(
                        a.href("/categories/", variable(\.id)).child(
                            variable(\.name)
                        )
                    )
            )
        }
    }
}
