import Foundation

//MARK: string validation

extension String {

    enum RegexType {
        case phoneNumber, name
        
        func get() -> String {
            switch self {
            case .phoneNumber:
                return "[0-9]{10}"
            case .name:
                return "^[a-zA-ZığüşöçİĞÜŞÖÇ ]+$"
            default:
                return ""
            }
        }
    }
    
    func isValid(_ type:RegexType) -> Bool {
        return NSPredicate(format:"SELF MATCHES %@", type.get()).evaluate(with: self)
    }
}
