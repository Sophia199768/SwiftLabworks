
protocol TaskRepository {
    func create(task: AppTask) -> AppTask
    func update(task: AppTask) -> AppTask
    func delete(id: Int128)
    func findAll() -> [AppTask]
    func get(id: Int128) -> AppTask
}
