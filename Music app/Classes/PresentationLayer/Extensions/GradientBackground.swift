import QuartzCore
final class Colors {
    var gl:CAGradientLayer!
    var colorTop: CGColor
    var colorBottom: CGColor
    
    init(colorTop: CGColor, colorBottom: CGColor) {
        self.colorTop = colorTop
        self.colorBottom = colorBottom
        self.gl = CAGradientLayer()
        self.gl.colors = [colorTop, colorBottom]
        self.gl.locations = [0.0, 0.5]
    }
}
