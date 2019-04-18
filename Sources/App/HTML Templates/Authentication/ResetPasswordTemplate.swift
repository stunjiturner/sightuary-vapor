
import HTMLKit
import Vapor

struct ResetPasswordTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let isError: Bool

        init(req: Request, isError: Bool = false) throws {
            self.base = try .init(title: "", req: req)
            self.isError = isError
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:

                h1.child(
                    variable(\.base.title)
                ),

                // Error message
                runtimeIf(
                    \.isError,
                    div.class("alert alert-danger").role("alert").child(
                        "There was a problem with the form. Ensure you clicked on the full link with the token and your passwords match."
                    )
                ),

                form.method(.post).child(

                    // Password input
                    div.class("form-group").child(
                        label.for("password").child(
                            "Password"
                        ),
                        input.type("password").name("password").class("form-control").id("password")
                    ),

                    // Confirm Password input
                    div.class("form-group").child(
                        label.for("confirmPassword").child(
                            "Confirm Password"
                        ),
                        input.type("password").name("confirmPassword").class("form-control").id("confirmPassword")
                    ),

                    // Reset button
                    button.type("submit").class("btn btn-primary").child(
                        "Reset"
                    )
                )
            ),
            withPath: \.base)
    }
}
