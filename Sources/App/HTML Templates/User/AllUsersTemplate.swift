
import HTMLKit
import Vapor

struct AllUsersTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let users: [User]

        init(users: [User], req: Request) throws {
            self.users = users
            self.base = try .init(title: "All Users", req: req)
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:

                h1.child("All Users"),

                runtimeIf(
                    \.users.count > 0,

                    table.class("table table-bordered table-hover").child(
                        thead.class("thead-light").child(
                            tr.child(
                                th.child("Username"),
                                th.child("Name")
                            )
                        ),

                        // All users
                        tbody.child(
                            forEach(in:     \.users,
                                    render: UserRow()
                            )
                        )
                    )
                ).else(
                    h2.child(
                        "There aren't any users yet!"
                    )
                )
            ),
            withPath: \.base)
    }

    // MARK: - Sub views

    struct UserRow: ContextualTemplate {

        typealias Context = User

        func build() -> CompiledTemplate {

            return
                tr.child(
                    td.child(
                        a.href("/users/", variable(\.id)).child(
                            variable(\.username)
                        )
                    ),
                    td.child(
                        variable(\.name)
                    )
            )
        }
    }
}
