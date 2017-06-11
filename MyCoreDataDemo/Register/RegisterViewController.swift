//
//  RegisterViewController.swift
//  MyCoreDataDemo
//
//  Created by Christophe Foucan on 07/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import CoreData

protocol RegisterViewDelegate {
    func close(_ controller:RegisterViewController)
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: MyCustomTextField!
    @IBOutlet weak var isbnTextField: MyCustomTextField!
    @IBOutlet weak var pagesTextField: MyCustomTextField!
    @IBOutlet weak var firstNameTextField: MyCustomTextField!
    @IBOutlet weak var lastNameTextField: MyCustomTextField!
    @IBOutlet weak var addButton: MyCustomButton!
    
    var books: [Book] = []
    var delegate:RegisterViewDelegate?
    
    class func registerViewController() -> RegisterViewController
    {
        let ctrl:RegisterViewController = RegisterViewController.init(nibName: "RegisterView", bundle: nil)
        return ctrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = Color.PICKLED_BLUEWOOD
        self.pagesTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addBook(_ sender: Any) {
        save()
        self.delegate?.close(self)
    }
    
    func save() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let book = Book(context: context)
        let author = Author(context: context)
        
        book.title = titleTextField.text!
        book.isbn = isbnTextField.text!
        book.pages = Int16(pagesTextField.text!)!
        
        author.firstName = firstNameTextField.text!
        author.lastName = lastNameTextField.text!
        book.author = author
        
        do {
            books = try context.fetch(Book.fetchRequest())
        }
        catch {
            print("fetching failed")
        }
        //Save data
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
    }
    
}

extension  RegisterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    func closekeyboard() {
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        closekeyboard()
    }
}
