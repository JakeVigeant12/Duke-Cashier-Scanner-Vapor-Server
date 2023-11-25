import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }

    app.get("hello") { req async -> String in
        "Hello, world!"
    }
    
    app.get("test") {  req -> EventLoopFuture<SelectionsResponse> in
        let jsonResponse = SelectionsResponse(
                    departments: ["Dining", "School Of Nursing", "Duke Stores", "Duke Card", "Parking", "Other"],
                    locations: [
                        "Dining": [
                            "Bella Union", "Beyu Blue", "Bseisu Coffee Bar", "Cafe at Duke Law", "Chefs Kitchen",
                            "Commons", "Devils Krafthouse", "Divinity Cafe", "Dolce Vita", "Farmstead", "Freeman Center",
                            "Ginger And Soy", "Gyotaku", "Il Forno", "JBS", "Loop", "Marketplace A La Carte",
                            "Marketplace Board AUCE", "McDonald's", "Nasher Cafe", "Panda Express", "Panera", "Perk",
                            "Pitchfork Provisions", "Quenchers", "Red Mango", "Sanford Deli", "Sazon", "Skillet",
                            "Sprout", "Tandor", "Terrace Cafe", "The Cafe", "Thrive Kitchen And Catering", "Trinity Cafe",
                            "Twinnies", "Other"
                        ],
                        "School Of Nursing": ["School of Nursing Cafe", "Other"],
                        "Duke Stores": [
                            "Computer Repair", "Divinity Store", "PG1", "Medical Office", "PG2", "Duke Children's Hospital",
                            "PG3", "Duke South Clinics", "PG4", "Duke Medical Pavilion", "PG5", "Duke North Hospital",
                            "PG7", "East Store", "Gothic Bookstore", "Lobby Shop", "eStore (Formerly Mail Order)",
                            "Merchandise Mail Order Concessions", "Medical Store", "Nasher Store", "Office Products",
                            "Team Store", "Technology Center", "Terrace Shop", "Textbook Store", "University Store",
                            "Warehouse", "Other"
                        ],
                        "Duke Card": ["Campus Office", "Medical Office", "The Link", "Other"],
                        "Parking": ["Parking Office", "Other"],
                        "Other" : ["Other"]
                    ],
                    posNames: [
                        "Sazon": ["p1"],
                        "Other": ["Other"]
                    ]
                )
                return req.eventLoop.makeSucceededFuture(jsonResponse)

    }

    try app.register(collection: TodoController())
}
