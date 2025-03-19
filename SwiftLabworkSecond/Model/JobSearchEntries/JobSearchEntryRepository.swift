
protocol JobSearchEntryRepository {
    func create() -> JobSearchEntry
    func update() -> JobSearchEntry
    func delete()
    func findAll() -> [JobSearchEntry]
    func get() -> [JobSearchEntry]
}


