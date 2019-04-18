
import HTMLKit
import Vapor

struct CreateAcronymTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let csrfToken: String?
        let categories: [Category]
        let isEditing: Bool

        init(req: Request, isEditing: Bool = false, categories: [Category] = []) throws {
            self.base = try .init(title: isEditing ? "Edit Acronym" : "Create An Acronym", req: req)
            self.csrfToken = try req.session()["CSRF_TOKEN"]
            self.isEditing = isEditing
            self.categories = categories
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:
                h1.child(
                    variable(\.base.title)
                ),

                form.method(.post).child(
                    runtimeIf(
                        \.csrfToken != nil,
                        input.type("hidden").name("csrfToken").value(
                            variable(\.csrfToken)
                        )
                    ),

                    // Short acronym form
                    div.class("form-group").child(
                        label.for("short").child(
                            "Acronym"
                        ),
                        input.type("text").name("short").class("form-control").id("short")
                    ),

                    // Long acronym form
                    div.class("form-group").child(
                        label.for("long").child(
                            "Meaning"
                        ),
                        input.type("text").name("long").class("form-control").id("long")
                    ),

                    // The different catagories
                    div.class("form-group").child(
                        label.for("categories").child(
                            "Categories"
                        ),

                        select.name("categories[]").class("form-control").id("categories").placeholder("Categories").multiple("multiple").child(
                            forEach(in:     \.categories,
                                    render: CategoryOption()
                            )
                        )
                    ),

                    // Submit button
                    button.type("submit").class("btn btn-primary").child(

                        runtimeIf(
                            \.isEditing,
                            "Update"
                        ).else(
                            "Submit"
                        )
                    )
                )
            ),
            withPath: \.base)
    }

    // MARk: - Sub views

    struct CategoryOption: ContextualTemplate {

        typealias Context = Category

        func build() -> CompiledTemplate {
            return
                option.value( variable(\.name)).selected.child(
                    variable(\.name)
            )
        }
    }
}
