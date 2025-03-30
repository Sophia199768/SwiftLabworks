
protocol AuthorizationService {

    func login(authorizationDto : AuthorizationDto) -> Bool
    func logout()
    func register(authorizationDto : CreateNewUserDto) -> Bool
    func validateInput(email: String) -> Bool
}
