
import HTMLKit
import Vapor

struct LoginTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let hasError: Bool

        init(req: Request, hasError: Bool = false) throws {
            self.base = try .init(title: "Log In", req: req)
            self.hasError = hasError
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:

                h1.child(
                    variable(\.base.title)
                ),

                // Error Message
                runtimeIf(
                    \.hasError,
                    div.class("alert alert-danger").role("alert").child(
                        "User authentication error. Either your username or password was invalid."
                    )
                ),

                // Form
                form.method(.post).child(

                    // User name input
                    div.class("form-group").child(
                        label.for("username").child(
                            "Username"
                        ),
                        input.type("text").name("username").class("form-control").id("username")
                    ),

                    // Password input
                    div.class("form-group").child(
                        label.for("password").child(
                            "Password"
                        ),
                        input.type("password").name("password").class("form-control").id("password")
                    ),

                    // Login button
                    button.type("submit").class("btn btn-primary").child(
                        "Log In"
                    )
                ),

                // Login alternatives
                a.href("/login-google").child(
                    img.class("mt-3").src("/images/sign-in-with-google.png").alt("Sign In With Google")
                ),
                a.href("/login-github").child(
                    img.class("mt-3").src("/images/sign-in-with-github.png").alt("Sign In With GitHub")
                ),
                br,

                // Forgotten password
                a.href("/forgottenPassword").child(
                    "Forgotten your password?"
                )
            ),
            withPath: \.base)
    }
}
