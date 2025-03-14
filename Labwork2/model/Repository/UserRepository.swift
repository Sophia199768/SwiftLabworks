
protocol UserRepository {
    func create(user: User) -> User
    func update(user: User) -> User
    func delete(id: Int128)
    func findAll() -> [User]
    func get(id: Int128) -> User
}

