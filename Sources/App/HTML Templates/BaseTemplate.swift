
import Vapor
import HTMLKit

/// A struct adding the doctype html tag
struct HTMLDocument: StaticView {

    let document: CompiledTemplate

    func build() -> CompiledTemplate {
        return [
            doctype("html"),
            document
        ]
    }
}


struct BaseTemplate: ContextualTemplate {

    struct Context {
        let title: String
        let userLoggedIn: Bool
        let showCookieMessage: Bool

        init(title: String = "Acronyms", req: Request) throws {
            self.title = title
            self.userLoggedIn = try req.isAuthenticated(User.self)
            self.showCookieMessage = req.http.cookies["cookies-accepted"] == nil
        }
    }

    let content: CompiledTemplate

    init(content: CompiledTemplate...) {
        self.content = content
    }

    func build() -> CompiledTemplate {
        return HTMLDocument(document:
            html.lang("en").child(
                head.child(
                    meta.charset("utf-8"),
                    meta.name("viewport").content("width=device-width, initial-scale=1, shrink-to-fit=no"),
                    link.rel("stylesheet").href("https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css").integrity("sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO").crossorigin("anonymous").type("text/css"),

                    runtimeIf(
                        \.title == "Create An Acronym" || \.title == "Edit Acronym",

                        link.rel("stylesheet").href("https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css").integrity("sha384-RdQbeSCGSeSdSlTMGnUr2oDJZzOuGjJAkQy1MbKMu8fZT5G0qlBajY0n0sY/hKMK").crossorigin("anonymous").type("text/css")
                    ),

                    link.rel("stylesheet").href("/styles/style.css").type("text/css"),
                    title.child(
                        variable(\.title), " | Acronyms"
                    ),
                    body.child(
                        nav.class("navbar navbar-expand-md navbar-dark bg-dark").child(
                            a.class("navbar-brand").href("/").child(
                                "TIL"
                            ),
                            button.class("navbar-toggler").type("button").dataToggle("collapse").dataTarget("#navbarSupportedContent").ariaControls("navbarSupportedContent").child(
                                span.class("navbar-toggler-icon")
                            ),
                            div.class("collapse navbar-collapse").id("navbarSupportedContent").child(
                                ul.class("navbar-nav mr-auto").child(

                                    li.class("nav-item")
                                        .if(\.title == "Home page", add: .class("active")).child(
                                            a.href("/").class("nav-link").child(
                                                "Home"
                                            )
                                    ),
                                    li.class("nav-item")
                                        .if(\.title == "All Users", add: .class("active")).child(
                                            a.href("/users").class("nav-link").child(
                                                "All Users"
                                            )
                                    ),
                                    li.class("nav-item")
                                        .if(\.title == "All Categories", add: .class("active")).child(
                                            a.href("/categories").class("nav-link").child(
                                                "All Categories"
                                            )
                                    ),
                                    li.class("nav-item")
                                        .if(\.title == "Create An Acronym", add: .class("active")).child(
                                            a.href("/acronyms/create").class("nav-link").child(
                                                "Create An Acronym"
                                            )
                                    ),
                                    runtimeIf(
                                        \.userLoggedIn == false,
                                        li.class("nav-item")
                                            .if(\.title == "Register", add: .class("active")).child(
                                                a.href("/register").class("nav-link").child(
                                                    "Register"
                                                )
                                        )
                                    )
                                ),
                                runtimeIf(
                                    \.userLoggedIn,

                                    form.class("form-inline").action("/logout").method(.post).child(
                                        input.class("nav-link btn").type("submit").value("Log out")
                                    )
                                )
                            )
                        ),
                        div.class("container mt-3").child(
                            content
                        ),

                        runtimeIf(
                            \.showCookieMessage,
                            div.id("cookieMessage").class("container").child(
                                span.class("muted").child(
                                    "This site uses cookies! To accept this, click ",
                                    a.href("#").onclick("cookiesConfirmed()").child(
                                        "OK"
                                    )
                                )
                            ),
                            script.src("/scripts/cookies.js").type("text/javascript")
                        ),
                        script.src("https://code.jquery.com/jquery-3.3.1.min.js").integrity("sha384-tsQFqpEReu7ZLhBV2VZlAu7zcOV+rXbYlF2cqB8txI/8aZajjp4Bqd+V6D5IgvKT").crossorigin("anonymous").type("text/javascript"),

                        runtimeIf(
                            \.title == "Create An Acronym" || \.title == "Edit Acronym",

                            script.src("https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/js/select2.min.js").integrity("sha384-uQwKPrmNkEOvI7rrNdCSs6oS1F3GvnZkmPtkntOSIiPQN4CCbFSxv+Bj6qe0mWDb").crossorigin("anonymous").type("text/javascript"),
                            script.src("/scripts/createAcronym.js").type("text/javascript")
                        ),
                        script.src("https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js").integrity("sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49").crossorigin("anonymous").type("text/javascript"),
                        script.src("https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js").integrity("sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy").crossorigin("anonymous").type("text/javascript")
                    )
                )
            )
        )
    }
}
