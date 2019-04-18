
import HTMLKit
import Vapor

struct RegisterTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let message: String?

        init(req: Request, message: String? = nil) throws {
            self.base = try .init(title: "Register", req: req)
            self.message = message
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
                    \.message != nil,
                    div.class("alert alert-danger").role("alert").child(
                        "Please fix the following errors:",
                        variable(\.message)
                    )
                ),
                form.method(.post).child(

                    // Name input
                    div.class("form-group").child(
                        label.for("name").child(
                            "Name"
                        ),
                        input.type("text").name("name").class("form-control").id("name")
                    ),

                    // Username input
                    div.class("form-group").child(
                        label.for("username").child(
                            "Username"
                        ),
                        input.type("text").name("username").class("form-control").id("username")
                    ),

                    // Email input
                    div.class("form-group").child(
                        label.for("emailAddress").child(
                            "Email Address"
                        ),
                        input.type("email").name("emailAddress").class("form-control").id("emailAddress")
                    ),

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

                    // Register Button
                    button.type("submit").class("btn btn-primary").child(
                        "Register"
                    )
                )
            ),
            withPath: \Context.base)
    }
}
