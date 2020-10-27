
import Foundation

struct SampleApiResource {}

extension SampleApiResource: ResourceType {
    var baseURL: URL {
        guard let url = URL(string: "https://breakingbadapi.com/api/characters") else {
            fatalError(baseURLFailureMessage)
        }
        return url
    }

    var httpMethod: HTTPMethod {
        return .get
    }

    var task: HTTPTask {
        return .requestParametersAndHeaders(bodyParameters: nil,
                                            bodyEncoding: encoding,
                                            urlParameters: nil,
                                            additionHeaders: nil)
    }

    var encoding: ParameterEncoding {
        return .jsonEncoding
    }
}
