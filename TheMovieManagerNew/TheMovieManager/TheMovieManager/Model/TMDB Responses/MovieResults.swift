import Foundation
//os resultados do filme sao uma estrutura codificavel com algumas propriedades, bem como uma enumeracao de chaves de codificacao
struct MovieResults: Codable {
    
    let page: Int
    let results: [Movie] //é uma variedade de filmes
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
