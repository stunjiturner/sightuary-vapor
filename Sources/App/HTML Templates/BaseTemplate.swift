
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
                    link.rel("stylesheet").href("https://cdn.jsdelivr.net/npm/fomantic-ui@2.7.4/dist/semantic.min.css").integrity("sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO").crossorigin("anonymous").type("text/css"),

                    runtimeIf(
                        \.title == "Create An Acronym" || \.title == "Edit Acronym",

                        link.rel("stylesheet").href("https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.0/css/select2.min.css").integrity("sha384-RdQbeSCGSeSdSlTMGnUr2oDJZzOuGjJAkQy1MbKMu8fZT5G0qlBajY0n0sY/hKMK").crossorigin("anonymous").type("text/css")
                    ),

                    link.rel("stylesheet").href("/styles/style.css").type("text/css"),
                    title.child(
                        variable(\.title), " | Acronyms"
                    ),
                    body.id("home").class("index").child(
                        nav.class("ui inverted black basic segment").child(
                            div.class("ui inverted horizontal linked list").child(
                                a.class("item").href("/").child(
                                    i.class("bars large link icon")),
                                a.class("logo ui image").href("/").child(
                                    img.class("ui medium image").src("https://sightuary-see-v4.s3.amazonaws.com/sites/56a5813dca5ffc000b000000/theme/images/logo20050.png?1530840765").alt(""))
                            ),
                        )),
                        div.class("ui grid").child(
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
