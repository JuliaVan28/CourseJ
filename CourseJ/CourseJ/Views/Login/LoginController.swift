import SwiftUI
import CoreData

final class LoginController: ObservableObject {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<User>
        
    var mailArray = [String]()
    var passwordArray = [String]()
    
    func doCredentialsExist(email: String, password: String) -> Bool {
        if users.contains(where: { $0.wrappedEmail == email && $0.wrappedPassword == password } ) {
          //  currentUser = users.first(where: { $0.wrappedEmail == email && $0.wrappedPassword == password })!
            return true
        } else { return false }
        /*
        do{
            ForEach(users) { user in
                if let mail = user.value(forKey: "email") as? String {
                    self.mailArray.append(mail)
                }
                if let password = user.value(forKey: "password") as? String{
                    self.passwordArray.append(password)
                }
                
            }
        }
        catch{
            print("error")
        }
         */
       // if users.contains(where: <#T##(User) throws -> Bool#>)
    }
}
