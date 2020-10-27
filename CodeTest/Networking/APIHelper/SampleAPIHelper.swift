import Foundation
class SampleAPIHelper {
    func getApiFeed(completion: @escaping (Result<SampleModel?, APIError>) -> Void) {
        let requestManager = RequestManager()
        let resource = SampleApiResource()
        guard let request = try? resource.makeRequest() else { return }
        requestManager.fetch(with: request, decode: { json -> SampleModel? in
            guard let model = json as? SampleModel
                else {
                    return nil
            }
            return model
        }, completion: completion)
    }
    
    

}
