

protocol JobSearchEntyService {
    func createJobSearchEntry(jobSearchEntryDto: JobSearchEntryDto) -> JobSearchEntryDto
    func updateJobSearchEntry(id: Int128 , jobSearchEntryDto: JobSearchEntryDto) -> JobSearchEntryDto
    func deleteJobSearchEntry(id: Int128) -> Void
    func getJobSearchEntry(id: Int128) -> JobSearchEntryDto
    func getAllJobSearchEnty() -> [JobSearchEntryDto]
}
