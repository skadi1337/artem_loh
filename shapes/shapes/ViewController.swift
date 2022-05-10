
import UIKit


func degree2radian(a:CGFloat)->CGFloat {
    let b = CGFloat(Double.pi) * a/180
    return b
}

func polygonPointArray(sides:Int,x:CGFloat,y:CGFloat,radius:CGFloat,adjustment:CGFloat=0)->[CGPoint] {
    let angle = degree2radian(a: 360/CGFloat(sides))
    let cx = x // x origin
    let cy = y // y origin
    let r  = radius // radius of circle
    var i = sides
    var points = [CGPoint]()
    while points.count <= sides {
        let xpo = cx - r * cos(angle * CGFloat(i)+degree2radian(a: adjustment))
        let ypo = cy - r * sin(angle * CGFloat(i)+degree2radian(a: adjustment))
        points.append(CGPoint(x: xpo, y: ypo))
        i-=1;
    }
    return points
}

func starPath(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int,pointyness:CGFloat) -> CGPath {
    let adjustment = 360/sides/2
    let path = CGMutablePath()
    let points = polygonPointArray(sides: sides,x: x,y: y,radius: radius)
    let cpg = points[0]
    let points2 = polygonPointArray(sides: sides,x: x,y: y,radius: radius*pointyness,adjustment:CGFloat(adjustment))
    var i = 0
    path.move(to: cpg)
    for p in points {
      //  CGPathAddLineToPoint(path, nil, points2[i].x, points2[i].y)
        path.addLine(to: points2[i])
        //CGPathAddLineToPoint(path, nil, p.x, p.y)
        path.addLine(to: p)
        i+=1
    }
    path.closeSubpath()
    return path
}

func drawStarBezier(x:CGFloat, y:CGFloat, radius:CGFloat, sides:Int, pointyness:CGFloat)->UIBezierPath {
    let path = starPath(x: x, y: y, radius: radius, sides: sides,pointyness: pointyness)
    let bez = UIBezierPath(cgPath: path)
    return bez
}





class ViewController: UIViewController
{
    
    @IBOutlet var imgv1: UIImageView!
    @IBOutlet var imgv2: UIImageView!
    @IBOutlet var imgv3: UIImageView!
    
    
    func im3()
    {
        let r = CGRect(x:0,y:0,width:100,height:100)
        let p = UIBezierPath()
        p.move(to: CGPoint(x: r.midX, y:r.minY))
        p.addLine(to: CGPoint(x:r.maxX, y:r.midY))
        p.addLine(to: CGPoint(x:r.midX,y:r.maxY))
        p.addLine(to: CGPoint(x:r.minX, y:r.midY))
        p.close()
        
        let shape = CAShapeLayer()
        shape.path = p.cgPath
        shape.frame = r
        
        shape.fillColor = UIColor.purple.cgColor
        
        
       
        
        let p1 = drawStarBezier(x: 50, y: 50, radius: 16.0, sides: 6, pointyness: 2)
        
        let shape2 = CAShapeLayer()
        shape2.path = p1.cgPath
        shape2.frame = r
        shape2.fillColor = UIColor.white.cgColor
        
         imgv3.layer.addSublayer(shape)
        imgv3.layer.addSublayer(shape2)
        
        
    }
    
   let shape = CAShapeLayer()
    func im2(c:CGRect)
    {
        let r = CGRect(x:0,y:0,width:210,height:200)
        let p = UIBezierPath()
        p.move(to: CGPoint(x: r.midX, y:r.minY))
        p.addLine(to: CGPoint(x:r.maxX, y:r.midY))
        p.addLine(to: CGPoint(x:r.midX,y:r.maxY))
        p.addLine(to: CGPoint(x:r.minX, y:r.midY))
        p.close()
        
         
        shape.path = p.cgPath
        shape.frame = r
        
         shape.fillColor = UIColor.green.cgColor
               shape.strokeColor = UIColor.cyan.cgColor
               shape.lineWidth = 0
        
        imgv2.layer.addSublayer(shape)
        
        
    }
    
    func im1(w: CGFloat, h:CGFloat)
    {
        let p = drawStarBezier(x: 105, y: 102, radius: 30.0, sides: 6, pointyness: 2)
        
        
        let shape = CAShapeLayer()
        shape.path = p.cgPath
        shape.frame = CGRect(x:0,y:0,width:210,height:205)
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x:0,y:0,width:210,height:205)
        gradient.colors = [UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.magenta.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x:1,y:0)
        gradient.mask = shape
        
        

      
        
        let shape2 = CAShapeLayer()
        shape2.path = p.cgPath
        shape2.frame = CGRect(x:0,y:0,width:210,height:205)
        shape2.strokeColor = UIColor.blue.cgColor
          shape2.lineWidth = 10
              shape2.shadowPath = p.cgPath
                    shape2.shadowRadius = 5
                    shape2.shadowOpacity = 1
                    shape2.shadowColor = UIColor.black.cgColor
        
        
       imgv1.layer.addSublayer(shape2)
        imgv1.layer.addSublayer(gradient)
  
    }
    
    func zoomout()
    {
        imgv1.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
    }
    
    
    
    func anim()
    {
      let options: UIView.AnimationOptions = [.curveEaseInOut,
                                              .repeat,
                                              .autoreverse]
      
      UIView.animate(withDuration: 2.9,
                     delay: 0,
                     options: options,
                     animations: { [weak self] in
                      self?.imgv1.frame.size.height *= 1.18
                      self?.imgv1.frame.size.width *= 1.18
      }, completion: nil)
        
        UIView.animate(withDuration: 1.5,
                    delay: 0.4,
                    options: [.repeat, .autoreverse],
                    animations: { [weak self] in
                        self?.imgv2.transform = CGAffineTransform(rotationAngle: .pi/2)
       }, completion: nil)
        
        
        UIView.animate(withDuration: 2.9,
                             delay: 0,
                             options: options,
                             animations: { [weak self] in
                                self?.imgv2.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
              }, completion: nil)
        
         UIView.animate(withDuration: 2.9,
                            delay: 0,
                            options: options,
                            animations: { [weak self] in
                                self?.imgv3.alpha = 0.5
             }, completion: nil)
    }
    
    
    @IBAction func tapa(_ sender: Any)
    
    {
        
        shape.fillColor = UIColor.black.cgColor
    }
    
    @IBAction func pincha(_ sender: Any)
    {
        shape.fillColor = UIColor.yellow.cgColor
    }
    
    @IBAction func longa(_ sender: Any)
    {
        shape.fillColor = UIColor.purple.cgColor
    }
    
    @IBAction func rota(_ sender: Any)
    {
        shape.fillColor = UIColor.cyan.cgColor
    }
    
    override func viewDidLoad()
    {
        
        
        
        super.viewDidLoad()
//imgv1.backgroundColor = UIColor.red
        im1(w: 50, h: 0)
        im2(c: CGRect(x:20,y:0,width: 210, height: 205))
        im3()
        anim()
        
        
        
    }
    
  


}

