import UIKit
import PlaygroundSupport

// MARK: MAGIC
extension UIControl {
    func onInteraction(
        for controlEvents: UIControl.Event = .primaryActionTriggered,
        action: @escaping (AnyObject) -> ()
    ) {
        let helper = UIControlHelper(
            attachTo: self,
            closure: action
        )
        
        addTarget(
            helper,
            action: #selector(UIControlHelper.invoke),
            for: controlEvents
        )
    }
}

class UIControlHelper {
    let closure: (AnyObject) -> ()
    
    init(attachTo: AnyObject, closure: @escaping (AnyObject) -> ()) {
        self.closure = closure
        objc_setAssociatedObject(
            attachTo,
            "[\(arc4random())]",
            self,
            .OBJC_ASSOCIATION_RETAIN
        )
    }
    
    @objc func invoke(sender: AnyObject) {
        closure(sender)
    }
}

// MARK: View
class MyViewController: UIViewController {
    override func loadView() {
        /// alleen voor playground
        let view = UIView()
        
        // MARK: onInteract logo
        let onInteractLBL = UILabel.init(
            frame: CGRect.init(
                x: 20, y: 100, width: 500, height: 100
            )
        )
        onInteractLBL.text = ".onInteraction { ... }"
        onInteractLBL.font = UIFont.boldSystemFont(ofSize: 40)
        view.addSubview(onInteractLBL)
        
        // MARK: Frame definitions
        let lblFrame1 = CGRect(
            x: 20, y: 200, width: 100, height: 30
        )
        let elementFrame1 = CGRect(
            x: 130, y: 200, width: 200, height: 30
        )
        
        let lblFrame2 = CGRect(
            x: 20, y: 240, width: 100, height: 30
        )
        let elementFrame2 = CGRect(
            x: 130, y: 240, width: 200, height: 30
        )
        
        let lblFrame3 = CGRect(
            x: 20, y: 280, width: 100, height: 30
        )
        let elementFrame3 = CGRect(
            x: 130, y: 280, width: 200, height: 30
        )
        
        let lblFrame4 = CGRect(
            x: 20, y: 320, width: 100, height: 30
        )
        let elementFrame4 = CGRect(
            x: 130, y: 320, width: 200, height: 30
        )
        
        // MARK: Background color
        view.backgroundColor = UIColor(
            red: 0,
            green: 212/255,
            blue: 255/255,
            alpha: 1.0
        )
        
        // MARK: Label 1 (UISegmentedControl)
        let label1 = UILabel.init()
        label1.frame = lblFrame1
        label1.text = "Interact -> "
        view.addSubview(label1)
        
        // MARK: Element 1 (UISegmentedControl)
        let segControl = UISegmentedControl.init(
            items: ["One", "Two", "Tri"]
        )
        
        segControl.frame = elementFrame1
        
        segControl.onInteraction { (xSender) in
            label1.text = xSender.titleForSegment(
                at: xSender.selectedSegmentIndex
            )
        }
        
        view.addSubview(segControl)
        
        // MARK: Label 2 (UISlider)
        let label2 = UILabel.init()
        label2.frame = lblFrame2
        label2.text = "Interact -> "
        view.addSubview(label2)
        
        // MARK: Element 2 (UISlider)
        let slider = UISlider.init()
        slider.frame = elementFrame2
        
        slider.onInteraction { (xSender) in
            label2.text = "\(((xSender as! UISlider).value * 100).rounded())%"
        }
        
        view.addSubview(slider)
        
        // MARK: Label 3 (UISwitch)
        let label3 = UILabel.init()
        label3.frame = lblFrame3
        label3.text = "Interact -> "
        view.addSubview(label3)
        
        // MARK: Element 3 (UISwitch)
        let switchy = UISwitch.init()
        switchy.frame = elementFrame3
        
        switchy.onInteraction { (xSender) in
            label3.text = xSender.isOn ? "On" : "Off"
        }
        
        view.addSubview(switchy)
        
        // MARK: Label 4 (UIButton)
        let label4 = UILabel.init()
        label4.frame = lblFrame4
        label4.text = "Interact -> "
        view.addSubview(label4)
        
        // MARK: Element 4 (UIButton)
        let button = UIButton.init()
        button.frame = elementFrame4
        button.setTitle("Test Button", for: .normal)
        
        button.onInteraction { (xSender) in
            // Encoded, just for fun.
            label4.text = "\u{1F913}\u{0026}\u{1F499}\u{003D}\u{1F60E}"
        }
        
        view.addSubview(button)
        
        // voor de playground
        self.view = view
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
