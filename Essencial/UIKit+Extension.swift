

import UIKit
import OBSlider
import MediaPlayer


// MARK: - UIView

@IBDesignable class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor? {
        didSet {
            configureView()
        }
    }
    @IBInspectable var bottomColor: UIColor? {
        didSet {
            configureView()
        }
    }
    
    override class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    override func tintColorDidChange() {
        super.tintColorDidChange()
        configureView()
    }
    
    func configureView() {
        let layer = self.layer as! CAGradientLayer
        let locations = [ 0.0, 1.0 ]
        layer.locations = locations as [NSNumber]
        let color1 = topColor ?? self.tintColor as UIColor
        let color2 = bottomColor ?? UIColor.black as UIColor
        let colors: Array <AnyObject> = [ color1.cgColor, color2.cgColor ]
        layer.colors = colors
    }
    
}


@IBDesignable class CircularView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension UIView {
    /**
     Remove all constraints from the view.
     */
    func removeConstraints() {
        if let superview = self.superview {
            for constraint in superview.constraints {
                if constraint.firstItem as? UIView == self || constraint.secondItem as? UIView == self {
                    constraint.isActive = false
                }
            }
        }
        for constraint in constraints {
            constraint.isActive = false
        }
    }
    
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

// MARK: - UIButton

@IBDesignable class PCTBorderButton: UIButton {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
            tintColor = borderColor
            setTitleColor(borderColor, for: UIControlState())
        }
    }
    override var isHighlighted: Bool {
        didSet {
            updateColor(isHighlighted)
        }
    }
    
    func updateColor(_ tint: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            if tint {
                self.backgroundColor =  self.borderColor ?? UIColor(red:0.37, green:0.41, blue:0.91, alpha:1.0)
                self.setTitleColor(UIColor.white, for: .highlighted)
            } else {
                self.backgroundColor = UIColor.clear
                self.setTitleColor(self.borderColor ?? UIColor(red:0.37, green:0.41, blue:0.91, alpha:1.0), for: UIControlState())
            }
        }) 
    }
}

@IBDesignable class PCTBlurButton: UIButton {
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            backgroundView.layer.cornerRadius = cornerRadius
            backgroundView.layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var blurTint: UIColor = UIColor.clear {
        didSet {
            backgroundView.contentView.backgroundColor = blurTint
        }
    }
    var blurStyle: UIBlurEffectStyle = .light {
        didSet {
            backgroundView.effect = UIBlurEffect(style: blurStyle)
        }
    }
    
    fileprivate var backgroundView: UIVisualEffectView
    
    override init(frame: CGRect) {
        backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        super.init(frame: frame)
        setUpButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
        super.init(coder: aDecoder)
        setUpButton()
    }
    
    func setUpButton() {
        backgroundView.frame = bounds
        backgroundView.isUserInteractionEnabled = false
        addSubview(backgroundView)
        sendSubview(toBack: backgroundView)
        let imageView = UIImageView(image: self.imageView!.image)
        imageView.frame = self.imageView!.bounds
        imageView.center = CGPoint(x: bounds.midX, y: bounds.midY)
        imageView.isUserInteractionEnabled = false
        self.imageView?.removeFromSuperview()
        addSubview(imageView)
        imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    override var isHighlighted: Bool {
        didSet {
            updateColor(isHighlighted)
        }
    }
    
    func updateColor(_ tint: Bool) {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: { 
            self.backgroundView.contentView.backgroundColor = tint ? UIColor.white : self.blurTint
            }, completion: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadius = bounds.width/2
    }
}

@IBDesignable class PCTHighlightedImageButton: UIButton {
    @IBInspectable var highlightedImageTintColor: UIColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setImage(self.imageView?.image?.withColor(highlightedImageTintColor), for: .highlighted)
    }
    
    override func setImage(_ image: UIImage?, for state: UIControlState) {
        super.setImage(image, for: state)
        super.setImage(image?.withColor(highlightedImageTintColor), for: .highlighted)
    }
}



// MARK: - String

func randomString(length: Int) -> String {
    let alphabet = "-_1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    let upperBound = UInt32(alphabet.characters.count)
    return String((0..<length).map { _ -> Character in
        return alphabet[alphabet.characters.index(alphabet.startIndex, offsetBy: Int(arc4random_uniform(upperBound)))]
        })
}

let downloadsDirectory: String = {
    let cachesPath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
    let downloadsDirectoryPath = cachesPath.appendingPathComponent("Downloads")
    if !FileManager.default.fileExists(atPath: downloadsDirectoryPath.relativePath) {
        try! FileManager.default.createDirectory(atPath: downloadsDirectoryPath.relativePath, withIntermediateDirectories: true, attributes: nil)
    }
    return downloadsDirectoryPath.relativePath
}()

//extension String {
//    func urlStringValues() -> [String: String] {
//        var queryStringDictionary = [String: String]()
//        let urlComponents = components(separatedBy: "&")
//        for keyValuePair in urlComponents {
//            let pairComponents = keyValuePair.components(separatedBy: "=")
//            let key = pairComponents.first?.stringByRemovingPercentEncoding
//            let value = pairComponents.last?.stringByRemovingPercentEncoding
//            queryStringDictionary[key!] = value!
//        }
//        return queryStringDictionary
//    }
//    
//    func sliceFrom(_ start: String, to: String) -> String? {
//        return (range(of: start)?.upperBound).flatMap { sInd in
//            let eInd = range(of: to, range: sInd..<endIndex)
//            if eInd != nil {
//                return (eInd?.lowerBound).map { eInd in
//                    return substring(with: sInd..<eInd)
//                }
//            }
//            return substring(with: sInd..<endIndex)
//        }
//    }
//}

// MARK: - Dictionary

extension Dictionary {
    
    func filter(_ predicate: (Element) -> Bool) -> Dictionary {
        var filteredDictionary = Dictionary()
        
//        for (key, value) in self {
//            if predicate(key, value) {
//                filteredDictionary[key] = value
//            }
//        }
        
        return filteredDictionary
    }
    
}

extension Dictionary where Value : Equatable {
    func allKeysForValue(_ val : Value) -> [Key] {
        return self.filter { $1 == val }.map { $0.0 }
    }
}

func += <K, V> (left: inout [K:V], right: [K:V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

// MARK: - NSLocale


extension Locale {
    
    fileprivate static var langs: NSDictionary {
        get {
            return [
                "af": "Afrikaans",
                "sq": "Albanian",
                "ar": "Arabic",
                "hy": "Armenian",
                "at": "Asturian",
                "az": "Azerbaijani",
                "eu": "Basque",
                "be": "Belarusian",
                "bn": "Bengali",
                "bs": "Bosnian",
                "br": "Breton",
                "bg": "Bulgarian",
                "my": "Burmese",
                "ca": "Catalan",
                "zh": "Chinese (simplified)",
                "zt": "Chinese (traditional)",
                "ze": "Chinese bilingual",
                "hr": "Croatian",
                "cs": "Czech",
                "da": "Danish",
                "nl": "Dutch",
                "en": "English",
                "eo": "Esperanto",
                "et": "Estonian",
                "ex": "Extremaduran",
                "fi": "Finnish",
                "fr": "French",
                "ka": "Georgian",
                "gl": "Galician",
                "de": "German",
                "el": "Greek",
                "he": "Hebrew",
                "hi": "Hindi",
                "hu": "Hungarian",
                "it": "Italian",
                "is": "Icelandic",
                "id": "Indonesian",
                "ja": "Japanese",
                "kk": "Kazakh",
                "km": "Khmer",
                "ko": "Korean",
                "lv": "Latvian",
                "lt": "Lithuanian",
                "lb": "Luxembourgish",
                "ml": "Malayalam",
                "ms": "Malay",
                "ma": "Manipuri",
                "mk": "Macedonian",
                "me": "Montenegrin",
                "mn": "Mongolian",
                "no": "Norwegian",
                "oc": "Occitan",
                "fa": "Persian",
                "pl": "Polish",
                "pt": "Portuguese",
                "pb": "Portuguese (BR)",
                "pm": "Portuguese (MZ)",
                "ru": "Russian",
                "ro": "Romanian",
                "sr": "Serbian",
                "si": "Sinhalese",
                "sk": "Slovak",
                "sl": "Slovenian",
                "es": "Spanish",
                "sw": "Swahili",
                "sv": "Swedish",
                "sy": "Syriac",
                "ta": "Tamil",
                "te": "Telugu",
                "tl": "Tagalog",
                "th": "Thai",
                "tr": "Turkish",
                "uk": "Ukrainian",
                "ur": "Urdu",
                "vi": "Vietnamese",
            ]
        }
    }
    
    static func commonISOLanguageCodes() -> [String] {
        return langs.allKeys as! [String]
    }
    
    static func commonLanguages() -> [String] {
        return langs.allValues as! [String]
    }
}

// MARK: - UITableViewCell

extension UITableViewCell {
    func relatedTableView() -> UITableView {
        if let superview = self.superview as? UITableView {
            return superview
        } else if let superview = self.superview?.superview as? UITableView {
            return superview
        } else {
            fatalError("UITableView shall always be found.")
        }
    }
    
    // Fixes multiple color bugs in iPads because of interface builder
    open override var backgroundColor: UIColor? {
        get {
            return backgroundView?.backgroundColor
        }
        set {
            backgroundView?.backgroundColor = backgroundColor
        }
    }
}


// MARK: - UIStoryboardSegue

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        source.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIImage

extension UIImage {

    func crop(_ rect: CGRect) -> UIImage {
        var rect = rect
        if self.scale > 1.0 {
            rect = CGRect(x: rect.origin.x * self.scale,
                              y: rect.origin.y * self.scale,
                              width: rect.size.width * self.scale,
                              height: rect.size.height * self.scale)
        }
        
        let imageRef = self.cgImage?.cropping(to: rect)
        return UIImage(cgImage: imageRef!, scale: self.scale, orientation: self.imageOrientation)
    }
    
    func withColor(_ color: UIColor?) -> UIImage {
        var color: UIColor! = color
        color = color ?? UIColor.appColor()
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        color.setFill()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.colorBurn)
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.draw(self.cgImage!, in: rect)
        context?.setBlendMode(CGBlendMode.sourceIn)
        context?.addRect(rect)
        context?.drawPath(using: CGPathDrawingMode.fill)
        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return coloredImage!
    }
    
    class func fromColor(_ color: UIColor?, inRect rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)) -> UIImage {
        var color: UIColor! = color
        color = color ?? UIColor.appColor()
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

}

// MARK: - NSFileManager

extension FileManager {
    func fileSizeAtPath(_ path: String) -> Int64 {
        do {
            let fileAttributes = try attributesOfItem(atPath: path)
            let fileSizeNumber = fileAttributes[FileAttributeKey.size]
            let fileSize = (fileSizeNumber as AnyObject).int64Value
            return fileSize!
        } catch {
            print("error reading filesize, NSFileManager extension fileSizeAtPath")
            return 0
        }
    }
    
    func folderSizeAtPath(_ path: String) -> Int64 {
        var size : Int64 = 0
        do {
            let files = try subpathsOfDirectory(atPath: path)
            for i in 0 ..< files.count {
                size += fileSizeAtPath((path as NSString).appendingPathComponent(files[i]) as String)
            }
        } catch {
            print("Error reading directory.")
        }
        return size
    }
}

// MARK: - UISlider

class PCTBarSlider: OBSlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var customBounds = super.trackRect(forBounds: bounds)
        customBounds.size.height = 3
        customBounds.origin.y -= 1
        return customBounds
    }
    
    override func awakeFromNib() {
        self.setThumbImage(UIImage(named: "Scrubber Image"), for: .normal)
        super.awakeFromNib()
    }
}

class PCTProgressSlider: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var customBounds = super.trackRect(forBounds: bounds)
        customBounds.size.height = 3
        customBounds.origin.y -= 1
        return customBounds
    }
    
    override func awakeFromNib() {
        self.setThumbImage(UIImage(named: "Progress Indicator")?.withColor(minimumTrackTintColor), for: UIControlState())
        setMinimumTrackImage(UIImage.fromColor(minimumTrackTintColor), for: UIControlState())
        setMaximumTrackImage(UIImage.fromColor(maximumTrackTintColor), for: UIControlState())
        super.awakeFromNib()
    }
    
    override func thumbRect(forBounds bounds: CGRect, trackRect rect: CGRect, value: Float) -> CGRect {
        var frame = super.thumbRect(forBounds: bounds, trackRect: rect, value: value)
        frame.origin.y += rect.origin.y
        return frame
    }
    
}

// MARK: - Magnets

func makeMagnetLink(_ torrHash: String) -> String {
    let trackers = [
        "udp://tracker.opentrackr.org:1337/announce",
        "udp://glotorrents.pw:6969/announce",
        "udp://torrent.gresille.org:80/announce",
        "udp://tracker.openbittorrent.com:80",
        "udp://tracker.coppersurfer.tk:6969",
        "udp://tracker.leechers-paradise.org:6969",
        "udp://p4p.arenabg.ch:1337",
        "udp://tracker.internetwarriors.net:1337",
        "udp://open.demonii.com:80",
        "udp://tracker.coppersurfer.tk:80",
        "udp://tracker.leechers-paradise.org:6969",
        "udp://exodus.desync.com:6969"
    ]
    let magnetURL = "magnet:?xt=urn:btih:\(torrHash)&tr=" + trackers.joined(separator: "&tr=")
    return magnetURL
}

//func cleanMagnet(_ url: String) -> String {
//    var hash: String
//    if !url.isEmpty {
//        if url.contains("&dn=") {
//            hash = url.sliceFrom("magnet:?xt=urn:btih:", to: "&dn=")!
//        } else {
//            hash = url.sliceFrom("magnet:?xt=urn:btih:", to: "")!
//        }
//        return makeMagnetLink(hash)
//    }
//    
//    return url
//}

// MARK: - UITableView

extension UITableView {
    func sizeHeaderToFit() {
        if let header = tableHeaderView {
            header.setNeedsLayout()
            header.layoutIfNeeded()
            let height = header.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            var frame = header.frame
            frame.size.height = height
            header.frame = frame
            tableHeaderView = header
        }
    }
}

// MARK: - CGSize

extension CGSize {
    static let max = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
}

// MARK: - UIViewController

extension UIScrollView {
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}

// MARK: - NSUserDefaults

extension UserDefaults {
    func reset() {
        for key in dictionaryRepresentation().keys {
            removeObject(forKey: key)
        }
    }
}

// MARK: - UIColor 

extension UIColor {
    class func appColor() -> UIColor {
        return UIColor(red:0.37, green:0.41, blue:0.91, alpha:1.0)
    }
}
