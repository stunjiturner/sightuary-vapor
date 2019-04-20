
import HTMLKit
import Vapor

struct IndexTemplate: ContextualTemplate {

    struct Context {
        let base: BaseTemplate.Context
        let acronyms: [Acronym]

        init(req: Request, acronyms: [Acronym]) throws {
            self.base = try .init(title: "Sightuary | Everymedia Purification and Cultivation", req: req)
            self.acronyms = acronyms
        }
    }

    func build() -> CompiledTemplate {
        return embed(
            BaseTemplate(
                content:

                div.class("ui inverted black basic segment").child(
                    div.class("ui equal width center aligned grid").child(
                        div.class("ui middle aligned column container").child(
                            h1.class("ui inverted huge header").child("Everymedia"),
                            h2.class("ui inverted header").child("Purification and Cultivation"),
                            div.class("ui sub header").child(
                                h2.class("ui inverted header").child("A digital territory staked and claimed, built on ethics, trust, honor and nobility, as practiced any where in the world"))),
                        comment(" //.page-scroll ")),
                    comment(" //.hero-text ")),
                
                comment("start: Priority Kids container segment "),
                div.class("ui inverted black basic segment").child(
                    comment(" END segment: Ethics "),
                    div.class("ui equal width center aligned grid").child(
                        div.class("ui middle aligned column container").child(
                            h1.class("ui massive text").child("We Are Rising Men"),
                            div.class("ui header").child(
                                h1.class("ui inverted sub header").child("A closer look into our youth development incubator")),
                            div.class("ui basic segment").child(
                                a.href("http://www.prioritykids.org").class("ui massive inverted orange button").child("Check The Kids")),
                            h3.class("ui right floated header").child("People and Humanity")),
                        comment(" //.page-scroll ")),
                    comment(" // PriorityKids ")),
                
                comment("start: Social segment "),
                div.class("ui inverted basic black segment").child(
                    div.class("ui equal width center aligned grid").child(
                        div.class("ui middle aligned sixteen wide column").child(
                            h1.class("ui inverted header").child("Social"),
                            div.class("ui stackable grid container").child(
                                div.class("ui inverted horizontal link list").child(
                                    a.href("https://www.instagram.com/sightuary/").class("item").child(
                                        i.class("massive instagram icon"),"| Instagram"),
                                    a.href("https://www.twitter.com/sightuary/").class("item").child(
                                        i.class("massive twitter icon"),"| Twitter"),
                                    a.href("#").class("item").child("| Dribble"),
                                    a.href("#").class("item").child(
                                        i.class("massive behance icon"),"| Behance")))),
                        comment(" //.page-scroll ")),
                    comment(" //.hero-text ")),
                comment("end: Content"),
                
                comment(" starts footer "),
                div.class("ui inverted vertical segment").child(
                    div.class("ui container").child(
                        div.class("ui inverted equal height stackable grid").child(
                            div.class("four wide column").child(
                                h2.class("ui inverted header").child("Sightuary")),
                            div.class("ten wide column").child(
                                div.class("ui inverted horizontal link list").child(
                                    a.href("#").class("item").child("About"),
                                    a.href("#").class("item").child("Privacy"),
                                    a.href("#").class("item").child("Press")))))),
                

                // List of acronyms
                embed(
                    AcronymListTemplate(),
                    withPath: \.acronyms
                )
            ),
            withPath: \.base)
    }
}
