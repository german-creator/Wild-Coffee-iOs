import UIKit
import AnyFormatKit
import Firebase

class CheckInViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var getCodeButton: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var viewTop: UIView!
    @IBOutlet weak var viewButtom: UIView!
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var verificationID: String?
    var prevVC: UIViewController?
    
    var delegate: UpdateProfileVCToLogin?
    
    
    override func viewDidLoad() {
        
        prevVC?.dismiss(animated: false, completion: nil)
        
        getCodeButton.layer.cornerRadius = 15
        getCodeButton.layer.borderWidth = 2
        getCodeButton.layer.borderColor = #colorLiteral(red: 0.6862745098, green: 0.9450980392, blue: 0.8862745098, alpha: 1)
        
    }
    
    @IBAction func donePressedName(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    @IBAction func donePressedPhone(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func getCodePressed(_ sender: UIButton) {
        
        phoneNumberTextField.resignFirstResponder()
        
        
        let s = phoneNumberTextField.text
        let phoneNumber = "+7" + s!.replacingOccurrences( of: "[^0-9]", with: "", options: .regularExpression).dropFirst()
        
        if nameTextField.text == ""{
            showErrod(error: "Пожалуйста, введите ваше имя")
        } else {
            if phoneNumber.count < 12 {
                showErrod(error: "Пожалуйста, введите ваш номер телефона")
            } else {
                FirebaseAuthentication.checkUserExist(phoneNumber: phoneNumber) { (exist) in
                    if exist {
                        self.showErrod(error: "Пользователь по такому номеру телефона уже существует, вы можете войти в аккаунт")
                    } else {
                        Auth.auth().languageCode = "ru";
                        
                        self.progressIndicator.isHidden = false
                        self.progressIndicator.startAnimating()
                        
                        self.viewButtom.isHidden = true
                        self.viewTop.isHidden = true
                        self.nameTextField.isHidden = true
                        self.getCodeButton.isHidden = true
                        self.phoneNumberTextField.isHidden = true
                        self.titleLabel.isHidden = true
                        
                        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
                            if let error = error {
                                
                                self.viewButtom.isHidden = false
                                self.viewTop.isHidden = false
                                self.nameTextField.isHidden = false
                                self.getCodeButton.isHidden = false
                                self.phoneNumberTextField.isHidden = false
                                self.progressIndicator.isHidden = true
                                self.titleLabel.isHidden = false
                                
                                
                                self.showErrod(error: error.localizedDescription)
                                return
                            }
                            
                            self.verificationID = verificationID
                            
                            self.codeTextField.isHidden = false
                            
                            self.codeTextField.becomeFirstResponder()
                            self.progressIndicator.isHidden = true
                            
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func phoneChangedTextField(_ sender: UITextField) {
        
        
        if (sender.text!.count > 14) {
            sender.deleteBackward()
        } else{
            guard let text = sender.text else { return }
            sender.text = text.applyPatternOnNumbers(pattern: "#(###)###-####", replacmentCharacter: "#")
        }
        
        
    }
    @IBAction func codeChangeTextField(_ sender: UITextField) {
        
        if sender.text!.count > 6 {
            sender.deleteBackward()
            
        }
        
        if sender.text!.count == 6{
        
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID!,
                verificationCode: sender.text!)
            
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error{
                    self.showErrod(error: error.localizedDescription)
                    return
                }
                
                FirebaseAuthentication.setUserToDatabase(uid: Auth.auth().currentUser!.uid, name: self.nameTextField.text!, phoneNumber: Auth.auth().currentUser!.phoneNumber!)
                
                self.delegate?.starLoginMode()
                self.dismiss(animated: true, completion: nil)
                self.prevVC?.dismiss(animated: false, completion: nil)

            }
        }
        
    }
    
    
    @IBAction func startHighlight(_ sender: UIButton) {
        getCodeButton.layer.borderColor =   #colorLiteral(red: 0.3817316294, green: 0.9095525146, blue: 0.8818981051, alpha: 0.2044360017)
    }
    
    @IBAction func stopHighlight(_ sender: UIButton) {
        getCodeButton.layer.borderColor =  #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
    }
    @IBAction func toLoginButtonPressed(_ sender: UIButton) {
        
        if prevVC != nil{
            self.dismiss(animated: true, completion: nil)
        }
        performSegue(withIdentifier: "toLoginFromCheckin", sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destinationVC = segue.destination as? LoginViewController {
            destinationVC.prevVC = self
            destinationVC.delegate = delegate
        }
        
        
    }
    
    func showErrod(error: String) {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        let titleFont = [NSAttributedString.Key.font: UIFont(name: "SFMono-Regular", size: 17.0)!]
        let titleAttrString = NSMutableAttributedString(string: error, attributes: titleFont)
        
        alert.setValue(titleAttrString, forKey: "attributedMessage")
        alert.view.tintColor = #colorLiteral(red: 0.4348584116, green: 0.920769155, blue: 0.9059947133, alpha: 1)
        
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
}
