//
//  MainViewController.swift
//  MyCoreDataDemo
//
//  Created by Christophe Foucan on 07/06/2017.
//  Copyright © 2017 Christophe Foucan. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var books: [Book] = []
    
    class func mainViewController() -> MainViewController
    {
        let ctrl:MainViewController = MainViewController.init(nibName: "MainView", bundle: nil)
        return ctrl
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MainViewController.addBook(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieve()
        tableView.reloadData()
    }
    
    @objc func addBook(_ sender: UIBarButtonItem) {
        let vc = RegisterViewController(nibName: "RegisterView", bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
        vc.delegate = self
    }
    
    func retrieve(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do {
            books = try context.fetch(Book.fetchRequest())
        }
        catch {
            print("fetching failed")
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        self.tableView.rowHeight = 60
        let book = books[indexPath.row]
        let firstName = book.author?.firstName!
        let lastName = book.author?.lastName!
        cell.titleLabel?.text = "📚 \(book.title!) 🖋 \(firstName!) \(lastName!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if editingStyle == .delete {
            // Delete
            let book = books[indexPath.row]
            context.delete(book)
            // Save data
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                books = try context.fetch(Book.fetchRequest())
            }
            catch {
                print("fetching failed")
            }
        }
        tableView.reloadData()
    }
}

extension MainViewController: RegisterViewDelegate {
    func close(_ controller: RegisterViewController) {
        navigationController!.popViewController(animated: true)
    }
}
