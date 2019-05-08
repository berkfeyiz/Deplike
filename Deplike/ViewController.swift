//
//  ViewController.swift
//  Deplike
//
//  Created by Feyiz on 02/05/19.
//  Copyright © 2019 Feyiz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchbar: UITextField!
    @IBOutlet var numberaftersearch: UILabel!
    
    @IBOutlet var image1: UIImageView!
    @IBOutlet var name1: UILabel!
    @IBOutlet var pop1: UILabel!
    
    @IBOutlet var image2: UIImageView!
    @IBOutlet var name2: UILabel!
    @IBOutlet var pop2: UILabel!
    
    @IBOutlet var image3: UIImageView!
    @IBOutlet var name3: UILabel!
    @IBOutlet var pop3: UILabel!
    
    @IBOutlet var image4: UIImageView!
    @IBOutlet var name4: UILabel!
    @IBOutlet var pop4: UILabel!
    
    @IBOutlet var image5: UIImageView!
    @IBOutlet var name5: UILabel!
    @IBOutlet var pop5: UILabel!
    
    @IBOutlet var image6: UIImageView!
    @IBOutlet var name6: UILabel!
    @IBOutlet var pop6: UILabel!
    
    @IBOutlet var image7: UIImageView!
    @IBOutlet var name7: UILabel!
    @IBOutlet var pop7: UILabel!

    @IBOutlet var image8: UIImageView!
    @IBOutlet var name8: UILabel!
    @IBOutlet var pop8: UILabel!
    
    @IBOutlet var image9: UIImageView!
    @IBOutlet var name9: UILabel!
    @IBOutlet var pop9: UILabel!
    
    @IBOutlet var image10: UIImageView!
    @IBOutlet var name10: UILabel!
    @IBOutlet var pop10: UILabel!

    @IBOutlet var image11: UIImageView!
    @IBOutlet var name11: UILabel!
    @IBOutlet var pop11: UILabel!
    
    @IBOutlet var image12: UIImageView!
    @IBOutlet var name12: UILabel!
    @IBOutlet var pop12: UILabel!
    
    @IBOutlet var image13: UIImageView!
    @IBOutlet var name13: UILabel!
    @IBOutlet var pop13: UILabel!
    
    @IBOutlet var image14: UIImageView!
    @IBOutlet var name14: UILabel!
    @IBOutlet var pop14: UILabel!
    
    @IBOutlet var image15: UIImageView!
    @IBOutlet var name15: UILabel!
    @IBOutlet var pop15: UILabel!
    
    @IBOutlet var image16: UIImageView!
    @IBOutlet var name16: UILabel!
    @IBOutlet var pop16: UILabel!
    
    @IBOutlet var image17: UIImageView!
    @IBOutlet var name17: UILabel!
    @IBOutlet var pop17: UILabel!
    
    @IBOutlet var image18: UIImageView!
    @IBOutlet var name18: UILabel!
    @IBOutlet var pop18: UILabel!
    
    @IBOutlet var image19: UIImageView!
    @IBOutlet var name19: UILabel!
    @IBOutlet var pop19: UILabel!
    
    @IBOutlet var image20: UIImageView!
    @IBOutlet var name20: UILabel!
    @IBOutlet var pop20: UILabel!
    
   
    @IBOutlet var more: UIButton!

    @IBOutlet var back: UIButton!
    
    @IBOutlet var tablename1: UILabel!
    @IBOutlet var tablepop1: UILabel!
    @IBOutlet var tablename2: UILabel!
    @IBOutlet var tablepop2: UILabel!
    
    
    
    @IBAction func popularsearch(_ sender: UIButton) {
        
        tablename1.isHidden = false
        tablename2.isHidden = false
        tablepop1.isHidden = false
        tablepop2.isHidden = false
        
        let popularitypath = "https://api.themoviedb.org/3/person/popular?api_key=37419e0b5068a826126bd5bd72b6d026&language=en-US"
        
       setinfototable(withUrl: popularitypath)
        more.isEnabled = true
        more.isHidden = false
    }
    
    @IBAction func morepopsearch(_ sender: Any) {
        page = page + 1
        
        let popularitypath = "https://api.themoviedb.org/3/person/popular?api_key=37419e0b5068a826126bd5bd72b6d026&language=en-US&page=\(page)"
        
        setinfototable(withUrl: popularitypath)
        back.isHidden = false
        back.isEnabled = true
        
    }
    @IBAction func search(_ sender: Any) {
        let searchstring = searchbar.text
        Actor.search(withName: searchstring!) { (results:[Actor]) in
            
            self.numberaftersearch.text = results.count.description
        }
    }
    @IBAction func backpopsearch(_ sender: UIButton) {
        if(page > 1){
        page = page - 1
        let popularitypath = "https://api.themoviedb.org/3/person/popular?api_key=37419e0b5068a826126bd5bd72b6d026&language=en-US&page=\(page)"
        
            setinfototable(withUrl: popularitypath)
        }
        if(page == 1)
        {back.isHidden = true}
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        more.isHidden = true
        back.isHidden = true
        tablename1.isHidden = true
        tablename2.isHidden = true
        tablepop1.isHidden = true
        tablepop2.isHidden = true
    }
    
    private func configuretextfields()
    {
        searchbar.delegate = self
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        imageView.alpha = 0
                        
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
    }
    func setinfototable(withUrl path:String)
    {
    
        Actor.popularities(withURL: path) { (results:[Actor])in
            
            
            self.get_image("https://image.tmdb.org/t/p/original\(results[0].photo)", self.image1)
            self.get_image("https://image.tmdb.org/t/p/original\(results[1].photo)", self.image2)
            self.get_image("https://image.tmdb.org/t/p/original\(results[2].photo)", self.image3)
            self.get_image("https://image.tmdb.org/t/p/original\(results[3].photo)", self.image4)
            self.get_image("https://image.tmdb.org/t/p/original\(results[4].photo)", self.image5)
            self.get_image("https://image.tmdb.org/t/p/original\(results[5].photo)", self.image6)
            self.get_image("https://image.tmdb.org/t/p/original\(results[6].photo)", self.image7)
            self.get_image("https://image.tmdb.org/t/p/original\(results[7].photo)", self.image8)
            self.get_image("https://image.tmdb.org/t/p/original\(results[8].photo)", self.image9)
            self.get_image("https://image.tmdb.org/t/p/original\(results[9].photo)", self.image10)
            self.get_image("https://image.tmdb.org/t/p/original\(results[10].photo)", self.image11)
            self.get_image("https://image.tmdb.org/t/p/original\(results[11].photo)", self.image12)
            self.get_image("https://image.tmdb.org/t/p/original\(results[12].photo)", self.image13)
            self.get_image("https://image.tmdb.org/t/p/original\(results[13].photo)", self.image14)
            self.get_image("https://image.tmdb.org/t/p/original\(results[14].photo)", self.image15)
            self.get_image("https://image.tmdb.org/t/p/original\(results[15].photo)", self.image16)
            self.get_image("https://image.tmdb.org/t/p/original\(results[16].photo)", self.image17)
            self.get_image("https://image.tmdb.org/t/p/original\(results[17].photo)", self.image18)
            self.get_image("https://image.tmdb.org/t/p/original\(results[18].photo)", self.image19)
            self.get_image("https://image.tmdb.org/t/p/original\(results[19].photo)", self.image20)
            
            self.name1.text = "\(results[0].name)"
            self.name2.text = results[1].name
            self.name3.text = results[2].name
            self.name4.text = results[3].name
            self.name5.text = results[4].name
            self.name6.text = results[5].name
            self.name7.text = results[6].name
            self.name8.text = results[7].name
            self.name9.text = results[8].name
            self.name10.text = results[9].name
            self.name11.text = results[10].name
            self.name12.text = results[11].name
            self.name13.text = results[12].name
            self.name14.text = results[13].name
            self.name15.text = results[14].name
            self.name16.text = results[15].name
            self.name17.text = results[16].name
            self.name18.text = results[17].name
            self.name19.text = results[18].name
            self.name20.text = results[19].name
            
            self.pop1.text = results[0].popularity.description
            self.pop2.text = results[1].popularity.description
            self.pop3.text = results[2].popularity.description
            self.pop4.text = results[3].popularity.description
            self.pop5.text = results[4].popularity.description
            self.pop6.text = results[5].popularity.description
            self.pop7.text = results[6].popularity.description
            self.pop8.text = results[7].popularity.description
            self.pop9.text = results[8].popularity.description
            self.pop10.text = results[9].popularity.description
            self.pop11.text = results[10].popularity.description
            self.pop12.text = results[11].popularity.description
            self.pop13.text = results[12].popularity.description
            self.pop14.text = results[13].popularity.description
            self.pop15.text = results[14].popularity.description
            self.pop16.text = results[15].popularity.description
            self.pop17.text = results[16].popularity.description
            self.pop18.text = results[17].popularity.description
            self.pop19.text = results[18].popularity.description
            self.pop20.text = results[19].popularity.description}
    }
    var page = 1
}

extension ViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
