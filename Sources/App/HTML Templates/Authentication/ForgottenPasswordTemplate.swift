
import HTMLKit
import Vapor

struct ForgottenPasswordTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context

        init(req: Request) throws {
            self.base = try .init(title: "Reset Your Password", req: req)
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

                    // Email input
                    div.class("form-group").child(
                        label.for("email").child(
                            "Email"
                        ),
                        input.type("email").name("email").class("form-control").id("email")
                    ),

                    // Submit button
                    button.type("submit").class("btn btn-primary").child(
                        "Reset Password"
                    )
                )
            ),
            withPath: \.base)
    }
}
