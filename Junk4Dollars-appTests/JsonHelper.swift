import Foundation

class JsonHelper {
    static func asJson(dictionary: [String:Any]) -> String {
      do {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
      } catch {
        return ""
      }
    }

    static func asJson(list: [[String:Any]]) -> String {
      do {
        let data = try JSONSerialization.data(withJSONObject: list, options: .prettyPrinted)
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
      } catch {
        return ""
      }
    }

}
