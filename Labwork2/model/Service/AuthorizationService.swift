
protocol AuthorizationService {

    func login(authorizationDto : AuthorizationDto) -> Bool
    func logout()
    func register(authorizationDto : AuthorizationDto) -> Bool
}
