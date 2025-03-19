
protocol NotificationRepository {
    func create(user: AppNotification) -> AppNotification
    func update(user: AppNotification) -> AppNotification
    func delete(id: Int128)
    func findAll() -> [AppNotification]
    func get(id: Int128) -> AppNotification
}

