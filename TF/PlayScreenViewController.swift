//
//  PlayScreenViewController.swift
//  TF
//
//  Created by AKINDE-PETERS JOSEPH on 8/4/17.
//  Copyright © 2017 AKINDE-PETERS JOSEPH. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth
import FirebaseDatabase


class PlayScreenViewController: UIViewController {
    
    var category = ""
    var result : [Int] = []
    var selectedAnswer = ""
    var rootRef : FIRDatabaseReference!
    
    var animation1 : LOTAnimationView!
    var animation2 : LOTAnimationView!
    var animation3 : LOTAnimationView!
    
    var selectionMade = false
    
    var timer = Timer()
    
    var gameStillOn = true
    var passedMsg = ""
    
    var position = 0 {
        didSet{
            positionlabel.text = "Question \(position + 1) of 10"
        }
    }
    
    var correctAnswers = 0
    
    var remainingLives = 3 {
        didSet{
            switch remainingLives {
            case 3:
                refillLife()
            case 2:
                animation3.play()
				animation3.isHidden = true
            case 1:
                animation2.play()
				animation2.isHidden = true
            case 0:
                animation1.play()
				animation1.isHidden = true
                passedMsg = "failure"
                gameOver()
                print("Game over")
            default:
                animation1.play()
            }
        }
    }
    
    var questions : [QuestionData] = []{
        didSet{
            if(questions.count == 4){
                refillLife()
                loadingView.alpha = 0.0
                showQuestion(position: position)
              //  print(questions[3].question)
            }
        }
    }

    var time = 30{
        didSet{
            if(time != 0){
                let fractionalProgress = Float(time) / 30.0
                progressView.setProgress(fractionalProgress, animated: true)
            }else{
                progressView.setProgress(0, animated: true)
                timer.invalidate()
                markQuestion()
            }
            
        }
    }
    
    
    @IBOutlet weak var life3: UIView!
    @IBOutlet weak var life2: UIView!
    @IBOutlet weak var life1: UIView!
	@IBOutlet weak var stackView: UIStackView!
	
    @IBOutlet weak var loadingView: UIView!
    
    @IBOutlet weak var trueCard: Card!
    @IBOutlet weak var falseCard: Card!
    
    @IBOutlet weak var trueLabel: UILabel!
    @IBOutlet weak var falseLabel: UILabel!
    @IBOutlet weak var positionlabel: UILabel!
    
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootRef = FIRDatabase.database().reference().child(category)
        
        loadQuestions()
		
        //
        let defaults = UserDefaults.standard
        let savedInfo = defaults.string(forKey: "demo")
        print("Saved data is \(String(describing: savedInfo))")
        
        
        //
        if let user = FIRAuth.auth()?.currentUser {
            print("User data is \(user.email ?? "not found")")
        }
        
    
    }
    
    func showQuestion(position : Int) {
        
        selectionMade = false
        selectedAnswer = ""
        
        trueLabel.textColor = UIColor.black
        falseLabel.textColor = UIColor.black

        trueCard?.backgroundColor = UIColor.white
        falseCard?.backgroundColor = UIColor.white
        
        if(position < questions.count){
            startTimer()
            questionLabel.text = questions[position].question
        }
        
    }
    
    func loadQuestions(){
        
        rootRef.child("count").observeSingleEvent(of: .value, with: { (dataSnapShot) in
            let count = dataSnapShot.value as? Int
            
            print("Number of questions is \(String(describing: count!))")
            
            let array = self.makeList(size: 10, upperLimit: count!)
            print(array)
            
            for number in array {
                
                self.rootRef.child("\(number)").observe(FIRDataEventType.value) { [weak self] (dataSnapShot : FIRDataSnapshot) in
                    
                    //Get question
                    let value = dataSnapShot.value as? NSDictionary
                    let q = value?["question"] as? String ?? ""
                    let a = value?["answer"] as? String ?? ""
                    
                    let question = QuestionData(question: q, answer: a)
                    self?.questions.append(question)
                    
                }
                
            }
            
        })
		
        
    }
    
    
    func makeList(size:Int, upperLimit:Int ) -> [Int] {
        for _ in 0..<size {
            pickRandomNumber(upperLimit)
        }
        return result.sorted()
    }
    
    
    func pickRandomNumber(_ upperLimit : Int){
        let randNum = Int(arc4random_uniform(UInt32(upperLimit)) + 1);
        if(result.contains(randNum)){
            pickRandomNumber(upperLimit)
        }else{
            result.append(randNum)
        }
    }
    
    func startTimer(){
        timer.invalidate()
        time = 30
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.time -= 1
            //print(self.time)
        }
    }
    
    func refillLife(){
		
        animation1 = LOTAnimationView.animationNamed("heart");
        animation1.frame = CGRect(x: 1, y: 1, width: 28, height: 28)
        animation1.center = life3.center
        animation1.contentMode = .scaleAspectFit
        animation1.animationSpeed = 0.8
        animation1.loopAnimation = false
        stackView.addSubview(animation1)
        
        
        animation2 = LOTAnimationView.animationNamed("heart");
        animation2.frame = CGRect(x: 1, y: 1, width: 28, height: 28)
        animation2.center = life2.center
        animation2.contentMode = .scaleAspectFit
        animation2.animationSpeed = 0.8
        animation2.loopAnimation = false
        stackView.addSubview(animation2)
        
        
        animation3 = LOTAnimationView.animationNamed("heart");
        animation3.frame = CGRect(x: 1, y: 1, width: 28, height: 28)
        animation3.center = life1.center
        animation3.contentMode = .scaleAspectFit
        animation3.animationSpeed = 0.8
        animation3.loopAnimation = false
        stackView.addSubview(animation3)
		
		life1.isHidden = true
		life2.isHidden = true
		life3.isHidden = true

    }

    @IBAction func selectTrue(_ sender: UITapGestureRecognizer) {
        
        
        if(selectionMade == false){
            
            selectionMade = true
            
            timer.invalidate()
            selectedAnswer = "true"
            trueLabel.textColor = UIColor.white
            
            
            let card = sender.view as? Card
            if(questions[position].answer == selectedAnswer){
                card?.backgroundColor = UIColor.init(red: 0/255, green: 210/255, blue: 27/255, alpha: 1)
            }else{
                card?.backgroundColor = UIColor.init(red: 249/255, green: 45/255, blue: 59/255, alpha: 1)
            }
            
            markQuestion()
        }
        
    }
   
    
    @IBAction func selectFalse(_ sender: UITapGestureRecognizer) {
        
        if(selectionMade == false){
            
            selectionMade = true
            
            timer.invalidate()
            selectedAnswer = "false"
            falseLabel.textColor = UIColor.white
            
            
            let card = sender.view as? Card
            if(questions[position].answer == selectedAnswer){
                card?.backgroundColor = UIColor.init(red: 0/255, green: 210/255, blue: 27/255, alpha: 1)
            }else{
                card?.backgroundColor = UIColor.init(red: 249/255, green: 45/255, blue: 59/255, alpha: 1)
            }
            
            markQuestion()
        }
        
    }
    
    func markQuestion(){
        
        if questions[position].answer != selectedAnswer {
            remainingLives -= 1
        }else{
            correctAnswers += 1
        }
        
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            if(self.position < 9){
                if self.gameStillOn {
                    self.position += 1
                    self.showQuestion(position: self.position)
                }
            }else{
                self.passedMsg = "success"
                self.gameOver()
                print("Questions over")
            }
            
        }
    }
    
    func gameOver() {
        
        self.gameStillOn = false
        timer.invalidate()
        
        /*
        
        let alert = UIAlertController(title: "Game over!", message: "Uh oh! You lost all your lives.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(action)
        
        present(alert, animated: true)
 
         */
        
        performSegue(withIdentifier: "game_over", sender: nil)
        
    }
   
    
    @IBAction func goBack(_ sender: Any) {
        timer.invalidate()
        dismiss(animated: true, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool{
        return false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "game_over" {
            if let newVC = segue.destination as? GameOverViewController {
                newVC.mode = passedMsg
                newVC.correctAnswers = correctAnswers
            }
        }
    }

}
