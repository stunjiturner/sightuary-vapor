
import HTMLKit
import Vapor

struct AddProfilePictureTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let username: String

        init(username: String, req: Request) throws {
            self.username = username
            self.base = try .init(title: "Add Profile Picture", req: req)
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:

                h1.child(
                    variable(\.base.title)
                ),

                // The picture form
                form.method(.post).enctype("multipart/form-data").child(
                    div.class("form-group").child(
                        label.for("picture").child(
                            "Select Picture for ", variable(\.username)
                        ),
                        input.type("file").name("picture").class("form-control-file").id("picture")
                    ),
                    button.type("submit").class("btn btn-primary").child(
                        "Upload"
                    )
                )
            ),
            withPath: \.base)
    }
}
