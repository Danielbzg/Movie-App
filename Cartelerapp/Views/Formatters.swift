import Foundation

//Definición del formato de fechas para el proyecto
extension DateFormatter {
    //Formato de fecha recibida en la respuesta de la API
    static let apiFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    //Formato de fecha deseada en la vista
    static let appFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
}
