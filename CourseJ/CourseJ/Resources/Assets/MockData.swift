import Foundation

enum MockData {
    static let adImages = [
        AdImage(image: "languageRec"),
        AdImage(image: "paintingRec"),
        AdImage(image: "codingRec"),
        AdImage(image: "designRec"),
    ]

    static let homeAdImages = [
        AdImage(image: "ads-1"),
        AdImage(image: "ads"),
        AdImage(image: "ads"),
    ]
    
    static let courseOne = Course()
/*
    static var courses = [
        swiftCourse,
        productDesignCourse,
        Course(id: 3, title: "Design Fundamentals", category: .design, modules: courseModules, rating: 4, author: "Mayatma Shibunamurthi",
               timeToCompleteInHours: 20, titleImage: "courseImage3", createdAt: Date()),
        Course(id: 4, title: "Painting for Dummies", category: .painting, modules: courseModules, rating: 3, author: "Mayatma Shibunamurthi",
               timeToCompleteInHours: 20, titleImage: "courseImage2", createdAt: Date()),
        Course(id: 5, title: "Visual Design", category: .visualIdentity, modules: courseModules, rating: 5, author: "Mayatma Shibunamurthi",
               timeToCompleteInHours: 20, titleImage: "courseImage1", createdAt: Date()),
        Course(id: 6, title: "Math Essential", category: .mathematics, modules: courseModules, rating: 2, author: "Mayatma Shibunamurthi",
               timeToCompleteInHours: 20, titleImage: "courseImage2", createdAt: Date()),
        Course(id: 7, title: "Listen and Compose", category: .music, modules: courseModules, rating: 4, author: "Mayatma Shibunamurthi",
               timeToCompleteInHours: 20, titleImage: "courseImage3", createdAt: Date()),
    ]

    private static var courseModules: [Course.CourseModule] {
        (0 ..< 22).map { _ in singleChoiceModule }
    }

    private static let imageHeight = 300
    private static let imageWidth = 400
    private static let imageURL = "https://picsum.photos/\(imageWidth)/\(imageHeight)"

    // MARK: - Product Design Course

    static var productDesignCourse = Course(
        id: 2,
        title: "Product Design v1.0",
        category: .design,
        modules: [
            productDesignArticleModule,
            productDesignMultiChoiceModule,
            productDesignSingleChoiceModule,
            productDesignWriteDownModule,
            productDesignSingleChoiceModule,
        ],
        rating: 5,
        author: "Markus Tannenbaum",
        timeToCompleteInHours: 20,
        titleImage: "courseImage2",
        createdAt: Date()
    )

    private static let productDesignArticleModule = Course.CourseModule(
        id: UUID(),
        title: "Product Design v1.0",
        type: .article,
        chapters: [
            Course.CourseModule.ArticleChapter(
                id: UUID(),
                chapterTitle: "Introduction",
                body: """
                Product design is the process designers use to blend user needs with business goals to help brands make consistently successful products. Product designers work to optimize the user experience in the solutions they make for their users—and help their brands by making products sustainable for longer-term business needs.

                Product designers help make products which aren’t just easy and delightful (or at least satisfying) to use, but also fine-tuned to do consistently well in the marketplace. They help define product goals, create product roadmaps (high-level summaries or 6–12-month forecasts of product offerings and features) and, ideally, help brands release successful products. Much like usability and user interface (UI) design are subsets of user experience (UX) design, UX design fits within product design. Indeed, UX designers are concerned with the entire process of acquiring and integrating a product (including aspects of branding). However, product designers extend this scope to carefully monitor their brands’ positions in the market over time. They gauge likely impacts of design decisions based on in-depth domain knowledge and keep teams and organizations mindful of bigger-picture and bottom-line realities, particularly for the mid- to long term. They can therefore prevent or minimize risky consequences of implementing designs, and help maximize and sustain gains.
                """,
                image: imageURL
            ),
            Course.CourseModule.ArticleChapter(
                id: UUID(),
                chapterTitle: "Design thinking",
                body: """
                Throughout a project, a product designer will usually guide your design team and stakeholders on return on investment (ROI) and lower-level concerns such as the placement of interface elements. The product designer’s eye for factors such as product desirability and value is a vital safeguard to keep a brand competitive. In addition to what they would do as generalist-oriented UX designers (e.g., conducting UX research, creating personas) product designers also inform and plan roadmaps in close collaboration with development and marketing teams to ensure the feasibility of implementing designs.
                """,
                image: imageURL
            ),
        ],
        question: nil,
        answers: [],
        correctAnswers: [],
        selectedAnswers: [],
        explanation: nil
    )

    private static let productDesignSingleChoiceModule = Course.CourseModule(
        id: UUID(),
        title: nil,
        type: .singleChoice,
        chapters: [],
        question: "What is the key to successful product design?",
        answers: ["Good design skills", "Understanding the end-user customer", "Flawless execution", "Great communication skills"],
        correctAnswers: ["Understanding the end-user customer"],
        selectedAnswers: [],
        explanation: "The key to successful product design is understanding the end-user customer, the person for whom the product is being created. Product designers attempt to solve real problems for real people by using empathy and knowledge of their prospective customers’ habits, behaviours, frustrations, needs, and wants."
    )

    private static let productDesignMultiChoiceModule = Course.CourseModule(
        id: UUID(),
        title: nil,
        type: .multiChoice,
        chapters: [],
        question: "“Product designer” may be your dream role if you:",
        answers: [
            "Enjoy developing and integrating business goals into design and product decisions",
            "Love participating in the entire design process",
            "Likes loud music",
            "Can analyze complex data to synthesize designs",
        ],
        correctAnswers: [
            "Love participating in the entire design process",
            "Enjoy developing and integrating business goals into design and product decisions",
            "Can analyze complex data to synthesize designs",
        ],
        selectedAnswers: [],
        explanation: """
        “Product designer” may be your dream role if you:

        - Enjoy developing and integrating business goals into design and product decisions;
        - Love participating in the entire design process;
        - Have deep knowledge in design and a solid understanding of business; and
        - Can analyze complex data to synthesize designs that satisfy business goals and user needs.
        """
    )

    private static let productDesignWriteDownModule = Course.CourseModule(
        id: UUID(),
        title: nil,
        type: .writeDown,
        chapters: [],
        question: "What is User Centered Design?",
        answers: [],
        correctAnswers: ["iterative design process"],
        selectedAnswers: [],
        explanation: """
        User-centered design (UCD) is an iterative design process in which designers focus on the users and their needs in each phase of the design process.
        """
    )

    // MARK: - Swift Course

    static var swiftCourse = Course(
        id: 1,
        title: "Swift Fundamentals",
        category: .coding,
        modules: [
            articleModule,
            singleChoiceModule,
            multiChoiceModule,
            writeDownModule,
        ],
        rating: 4,
        author: "Mahatma Shibunamurthi",
        timeToCompleteInHours: 5,
        titleImage: "courseImage1",
        createdAt: Date()
    )

    private static let articleModule = Course.CourseModule(
        id: UUID(),
        title: "Swift introduction",
        type: .article,
        chapters: [
            Course.CourseModule.ArticleChapter(
                id: UUID(),
                chapterTitle: "The basics",
                body: """
                Swift is a new programming language for iOS, macOS, watchOS, and tvOS app development. Nonetheless, many parts of Swift will be familiar from your experience of developing in C and Objective-C.

                Swift provides its own versions of all fundamental C and Objective-C types, including Int for integers, Double and Float for floating-point values, Bool for Boolean values, and String for textual data. Swift also provides powerful versions of the three primary collection types, Array, Set, and Dictionary, as described in Collection Types.

                Like C, Swift uses variables to store and refer to values by an identifying name. Swift also makes extensive use of variables whose values can’t be changed. These are known as constants, and are much more powerful than constants in C. Constants are used throughout Swift to make code safer and clearer in intent when you work with values that don’t need to change.
                """,
                image: imageURL
            ),
            Course.CourseModule.ArticleChapter(
                id: UUID(),
                chapterTitle: "Basic Operators",
                body: """
                An operator is a special symbol or phrase that you use to check, change, or combine values. For example, the addition operator (+) adds two numbers, as in let i = 1 + 2, and the logical AND operator (&&) combines two Boolean values, as in if enteredDoorCode && passedRetinaScan.

                Swift supports the operators you may already know from languages like C, and improves several capabilities to eliminate common coding errors. The assignment operator (=) doesn’t return a value, to prevent it from being mistakenly used when the equal to operator (==) is intended.

                Swift also provides range operators that aren’t found in C, such as a..<b and a...b, as a shortcut for expressing a range of values.
                """,
                image: imageURL
            ),
        ],
        question: nil,
        answers: [],
        correctAnswers: [],
        selectedAnswers: [],
        explanation: nil
    )

    private static let singleChoiceModule = Course.CourseModule(
        id: UUID(),
        title: nil,
        type: .singleChoice,
        chapters: [],
        question: "Which one is an Assignment Operator?",
        answers: ["-", "++", "=", "=="],
        correctAnswers: ["="],
        selectedAnswers: [],
        explanation: "The assignment operator = initializes or updates the value"
    )

    private static let multiChoiceModule = Course.CourseModule(
        id: UUID(),
        title: nil,
        type: .multiChoice,
        chapters: [],
        question: "Which are Arithmetic Operators?",
        answers: ["+", "==", "-", "/"],
        correctAnswers: ["+", "-", "/"],
        selectedAnswers: [],
        explanation: """
        Swift supports the four standard arithmetic operators for all number types:

        - Addition (+)
        - Subtraction (-)
        - Multiplication (*)
        - Division (/)
        """
    )

    private static let writeDownModule = Course.CourseModule(
        id: UUID(),
        title: nil,
        type: .writeDown,
        chapters: [],
        question: "How does equal to operator look like?",
        answers: [],
        correctAnswers: ["=="],
        selectedAnswers: [],
        explanation: """
        Swift supports the four standard arithmetic operators for all number types:

        - Addition (+)
        - Subtraction (-)
        - Multiplication (*)
        - Division (/)
        """
    )
 */
}
