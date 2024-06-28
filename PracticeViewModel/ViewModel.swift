
import Foundation
import Combine

// 사용자 정보를 업데이트하는 함수
// ObservableObject : SwiftUI에서 이 클래스를 관찰할 수 있도록 함
class UserViewModel: ObservableObject {
    // @Published : 정의된 속성들이 변경되면 SwiftUI에서 자동으로 UI를 업데이트 함
    @Published var user: User = User(name: "", email: "")
    @Published var errorMessage: String?
    
    // 이름과 이메일이 비어있는지 확인. 비어 있으면 에러 메시지 설정 후 함수 종료
    func updateUser(name: String, email: String) {
        guard !name.isEmpty, !email.isEmpty else {
            errorMessage = "Name and email cannot be empty."
            // return : 함수나 메서드의 실행을 종료, 호출한 곳으로 값을 반환.
            // return 뒤 코드가 없으면 단순히 실행을 종료하고 아무런 값을 반환하지 않는다는 의미
            return
        }
        
        // 이메일이 유효하지 않으면 에러 메시지를 설정하고 함수 종료
        if !isValidEmail(email) {
            errorMessage = "Invalid email address."
            return
        }
        
        // 이름과 이메일이 유효하면 사용자 정보 업데이트 후 에러 메시지 초기화
        // 초기화하는 이유: 유효하지 않았던 경우 이전에 저장된 메시지를 제거
        user.name = name
        user.email = email
        errorMessage = nil
    }
    
    // 이메일 유효성을 검증하는 private 함수
    // _ : 외부 매개변수를 사용하지 않겠다는 의미
    private func isValidEmail(_ email: String) -> Bool {
        
        // 이메일 정규 표현식
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        // 정규 표현식을 사용하여 이메일 형식 검사
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        // 정규 표현식이 맞으면 true, 맞지 않으면 false 반환
        // evaluate(with:_) : Returns a Boolean value that indicates whether the specified object matches the conditions that the predicate specifies.
        return emailPred.evaluate(with: email)
    }
}
