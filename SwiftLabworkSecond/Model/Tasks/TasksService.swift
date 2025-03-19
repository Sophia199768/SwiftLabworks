
protocol TasksService {
    func createTask(task: TaskDto) -> TaskDto
    func updateTask(task: TaskDto) -> TaskDto
    func deleteTask(id: Int128) -> Bool
    func getAllTasks() -> [TaskDto]
}
