import Foundation

public class JsonHelper {
    public static func asJson(dictionary: [String:Any]) -> String {
      do {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
      } catch {
        return ""
      }
    }

    public static func asJson(list: [[String:Any]]) -> String {
      do {
        let data = try JSONSerialization.data(withJSONObject: list, options: .prettyPrinted)
        return String(data: data, encoding: String.Encoding.utf8) ?? ""
      } catch {
        return ""
      }
    }

}
