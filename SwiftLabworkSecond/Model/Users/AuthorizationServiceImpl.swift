import Foundation

class AuthorizationServiceImpl: AuthorizationService {
    private let userRepository: UserRepository
    private var newId = 1;
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func login(authorizationDto: AuthorizationDto) -> Bool {
        let users = userRepository.findAll()
        return users.contains { $0.login == authorizationDto.email && $0.password == authorizationDto.password }
    }
    
    func logout() {
        print("User logged out")
    }
    
    //регистрация
    func register(authorizationDto : CreateNewUserDto) -> Bool {
        let isExist = AuthorizationDto(email: authorizationDto.login, password: authorizationDto.password)
       
        if (login(authorizationDto: isExist)) {
            return false;
        }
        
        let newUser = User(id: Int128(newId), login: authorizationDto.login, name: authorizationDto.name, surname: authorizationDto.surname, patronymic: authorizationDto.patronymic, male: authorizationDto.male, password: authorizationDto.password, workStatus: authorizationDto.workStatus)
        
        userRepository.create(user: newUser)
        
        newId += 1
        return true
    }
    
    
    //- Добавить валидацию email и/или пароля в реальном времени с отображением невалидности
    func validateInput(email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        if !predicate.evaluate(with: email) {
            return false
        }
        return true
    }
}

