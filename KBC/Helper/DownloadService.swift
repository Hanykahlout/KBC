//
//  DownloadService.swift
//  KBC
//
//  Created by Hany Alkahlout on 10/9/24.
//



import Foundation
import Combine

//class DownloadService {
//    static let shared = DownloadService()
//    private init() {}
//    
//    func downloadIpa() -> AnyPublisher<URL, Error> {
//        guard let url = URL(string: AppConfig.MAIN_DOMAIN + "/r/front/ipa/KBC.ipa") else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
//        }
//        
//        return URLSession.shared.dataTaskPublisher(for: url)
//            .tryMap { (data, response) -> URL in
//                let fileManager = FileManager.default
//                let destinationURL = fileManager.temporaryDirectory.appendingPathComponent(
//                    "KBC.ipa"
//                )
//                try data.write(to: destinationURL)
//                return destinationURL
//            }
//            .eraseToAnyPublisher()
//    }
//    
//    func parseUpdateInfo(from url: URL) -> AnyPublisher<UpdateInfo, Error> {
//        return Future { promise in
//            do {
//                let data = try Data(contentsOf: url)
//                let plist = try PropertyListSerialization.propertyList(from: data, options: [], format: nil)
//                
//                guard let dict = plist as? [String: Any],
//                      let items = dict["items"] as? [[String: Any]],
//                      let firstItem = items.first,
//                      let metadata = firstItem["metadata"] as? [String: Any],
//                      let bundleVersion = metadata["bundle-version"] as? String,
//                      let downloadURL = metadata["url"] as? String else {
//                    throw NSError(domain: "PlistParsingError", code: 0, userInfo: nil)
//                }
//                
//                let updateInfo = UpdateInfo(version: bundleVersion, downloadURL: downloadURL)
//                promise(.success(updateInfo))
//            } catch {
//                promise(.failure(error))
//            }
//        }.eraseToAnyPublisher()
//    }
//}
