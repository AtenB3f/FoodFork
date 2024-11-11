import ProjectDescription

let workspace = Workspace(name: "FoodFork",
                          projects: [
                            .relativeToRoot("Projects/FoodFork"),
                            .relativeToRoot("Projects/Data"),
                            .relativeToRoot("Projects/Utility"),
                            .relativeToRoot("Projects/Domain"),
                            .relativeToRoot("Projects/Design")
                          ])

