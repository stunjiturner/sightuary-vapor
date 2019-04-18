
import HTMLKit
import Vapor

struct ForgottenPasswordConfirmedTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context

        init(req: Request) throws {
            self.base = try .init(title: "Password Reset Email Sent", req: req)
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:
                h1.child(
                    variable(\.base.title)
                ),
                p.child(
                    "Instructions to reset your password have been emailed to you."
                )
            ),
            withPath: \.base)
    }
}
