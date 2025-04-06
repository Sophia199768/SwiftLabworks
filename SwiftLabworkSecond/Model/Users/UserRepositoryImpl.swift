class UserRepositoryImpl: UserRepository {
    private var users: [User] = [
        User(id: 1, login: "sophiabrovkina1234@gmail.com", name: "Sophia", surname: "Brovkina",
             patronymic: "Vadimovna", male: "W", password: "1234", workStatus: "Active")
    ]
    
    func create(user: User) -> User {
        var newUser = user
        newUser.id = Int128(users.count + 1)
        users.append(newUser)
        return newUser
    }
    
    func update(user: User) -> User {
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
            return user
        }
        fatalError("User with id \(user.id) not found")
    }
    
    func delete(id: Int128) {
        users.removeAll { $0.id == id }
    }
    
    func findAll() -> [User] {
        return users
    }
    
    func get(id: Int128) -> User {
        guard let user = users.first(where: { $0.id == id }) else {
            fatalError("User with id \(id) not found")
        }
        return user
    }
}
