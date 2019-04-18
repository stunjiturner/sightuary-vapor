
import HTMLKit
import Vapor

struct AcronymTemplate: ContextualTemplate {

    struct Context {
        let acronym: Acronym
        let user: User
        let categories: [Category]
        let base: BaseTemplate.Context

        init(req: Request, user: User, acronym: Acronym, categories: [Category]) throws {
            self.acronym = acronym
            self.user = user
            self.categories = categories
            self.base = try .init(title: acronym.short, req: req)
        }
    }

    func build() -> CompiledTemplate {

        return embed(
            BaseTemplate(
                content:

                h1.child(variable(\.acronym.short)),
                h2.child(variable(\.acronym.long)),
                p.child(
                    "Created by ",
                    a.href("/users/", variable(\.user.id)).child(
                        variable(\.user.name)
                    )
                ),
                runtimeIf(
                    \.categories.count > 0,

                    h3.child("Categories"),

                    // All catagories
                    ul.child(
                        forEach(in:     \.categories,
                                render: CatagoryView()
                        )
                    )
                ),

                // Delete and edit Acronym
                form.method(.post).action("/acronyms/", variable(\.acronym.id), "/delete").child(
                    a.class("btn btn-primary").href("/acronyms/", variable(\.acronym.id) ,"/edit").role("button").child(
                        "Edit"
                    ),
                    "  ",
                    input.class("btn btn-danger").type("submit").value("Delete")
                )
            ),
            withPath: \.base)
    }


    // MARK: - Sub views

    struct CatagoryView: ContextualTemplate {

        typealias Context = Category

        func build() -> CompiledTemplate {
            return
                li.child(
                    a.href(["/categories/", variable(\.id)]).child(
                        variable(\.name)
                    )
            )
        }
    }
}
