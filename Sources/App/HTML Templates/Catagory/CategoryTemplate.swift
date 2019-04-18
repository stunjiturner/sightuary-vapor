
import HTMLKit
import Vapor

struct CategoryTemplate: ContextualTemplate {

    struct Context {
        let category: Category
        let base: BaseTemplate.Context
        let acronyms: [Acronym]

        init(category: Category, acronyms: [Acronym], req: Request) throws {
            self.category = category
            self.acronyms = acronyms
            self.base = try .init(title: category.name, req: req)
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(content:
                h2.child(
                    variable(\.category.name)
                ),
                embed(
                    AcronymListTemplate(),
                    withPath: \.acronyms
                )
            ),
            withPath: \Context.base)
    }
}
