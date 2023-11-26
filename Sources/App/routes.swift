import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req async throws in
        try await req.view.render("index", ["title": "Hello Vapor!"])
    }
    // render the admin panel
    app.get("admin", "create") { req -> EventLoopFuture<View> in
        return req.view.render("adminPanel", ["title": "Admin Panel"])
    }

    // endpoint to post new messages from the admin panel
    app.post("admin", "create", use:createMessageHandler)


    // get selections json file from database
    app.get("selections") { req async throws in
        try await Selections.query(on: req.db).all()
    }

    
    // add new message
    app.post("messages", "create", use: createMessageHandler)
    
    // get messages sent to this user
    app.get("messages", ":id") { req -> [Message] in
        // Extract Id from URL
        if let id = req.parameters.get("id", as: String.self) {
//            let responseBody = "Received ID: \(id)"
    
            let messages = try await Message.query(on: req.db)
                .filter(\.$receiverID == id)
                .sort(\.$timestamp)
                .all()
            return messages
            
        } else {
            // Handle the case where 'id' is not a valid integer
            throw Abort(.badRequest, reason: "Invalid 'id' parameter")
        }
    }
    
    // return static list of the selection options
    
    app.get("selection_options") {  req -> EventLoopFuture<SelectionsResponse> in
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
    


}
