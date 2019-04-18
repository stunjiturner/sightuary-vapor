
import HTMLKit
import Vapor

struct AcronymListTemplate: ContextualTemplate {

    typealias Context = [Acronym]

    func build() -> CompiledTemplate {
        return
            runtimeIf(
                \.count > 0,

                table.class("table table-bordered table-hover").child(
                    thead.class("thead-light").child(
                        tr.child(
                            th.child("Short"),
                            th.child("Long")
                        )
                    ),

                    // All the rows
                    tbody.child(
                        forEach(
                            render: AcronymRow()
                        )
                    )
                )
            ).else(
                "There aren’t any acronyms yet!"
            )
    }

    
    // MARK: - Sub views

    struct AcronymRow: ContextualTemplate {

        typealias Context = Acronym

        func build() -> CompiledTemplate {
            return
                tr.child(
                    td.child(
                        a.href(["/acronyms/", variable(\.id)]).child(
                            variable(\.short)
                        )
                    ),
                    td.child(
                        variable(\.long)
                    )
            )
        }
    }
}
