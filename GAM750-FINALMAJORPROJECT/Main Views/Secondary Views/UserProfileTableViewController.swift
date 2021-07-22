//
//  UserProfileTableViewController.swift
//  GAM750-FINALMAJORPROJECT
//
//  Created by Rachel Saunders on 17/07/2021.
//
//
// This is my Final Major Project for the course MA Creative App Development at Falmouth University.
//


import UIKit
import SKPhotoBrowser


protocol UserProfileTableViewControllerDelegate {
    func didLikeUser()
    func didDislikeUser()
}


class UserProfileTableViewController: UITableViewController {

    
    //MARK:-IBOUTLETS
    
    
    @IBOutlet weak var sectionOneView: UIView!
    
    @IBOutlet weak var sectionTwoView: UIView!
    
    @IBOutlet weak var sectionThreeView: UIView!
    
    @IBOutlet weak var sectionFourView: UIView!
    
    @IBOutlet weak var sectionFiveView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var dislikeButtonOutlet: UIButton!
    
    @IBOutlet weak var likeButtonOutlet: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // TEXT VIEWS
    
    @IBOutlet weak var aboutTextView: UITextView!
    
    @IBOutlet weak var diagnosesTextView: UITextView!
    
    // LABELS
    
    @IBOutlet weak var professionLabel: UILabel!
    
    @IBOutlet weak var jobLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var lookingForLabel: UILabel!
    
    //MARK:- VARS
    
    var userObject: FUser?
    var delegate: UserProfileTableViewControllerDelegate?
    
    
    
    
    var allImages: [UIImage] = []
    
    var isMatchedUser = false
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 5.0)
    
    
    
    //MARK:- VIEW LIFE CYCLE
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        pageControl.hidesForSinglePage = true
        
        
        if userObject != nil {
            updateLikeButtonStatus()
            showUserDetails()
            loadImages()
        
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBackgrounds()
        hideActivityIndicator()
        
        if isMatchedUser {
            updateUIForMatchedUser()
        }
        
        
    }
    
    //MARK:- IB ACTIONS
    
    @IBAction func dislikeButtonPressed(_ sender: Any) {
        
        self.delegate?.didDislikeUser()
        
        if self.navigationController != nil {
            navigationController?.popViewController(animated: true)
        } else {
            dismissView()
        }
    
    }
    
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        
        self.delegate?.didLikeUser()
        
        if self.navigationController != nil {
            // comment out the below line to test the likes and dislike function - it then doesnt take away the liked/disliked users for the user.
            saveLikeToUser(userId: userObject!.objectId)
            FirebaseListener.shared.saveMatch(userId: userObject!.objectId)
            showMatchView()
            
        } else {
            dismissView()
        }
        
    }
    
    @objc func startChatButtonPressed() {
        goToChat()
    }
    
    
    
    
    //MARK:- TABLE VIEW DELEGATE
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 0 : 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
        
    }

    
    //MARK:- SETUP UI
    
    private func setupBackgrounds() {

        sectionOneView.clipsToBounds = true
        sectionOneView.layer.cornerRadius = 30
        sectionOneView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        sectionTwoView.layer.cornerRadius = 10
        sectionThreeView.layer.cornerRadius = 10
        sectionFourView.layer.cornerRadius = 10
        sectionFiveView.layer.cornerRadius = 10
    }
    
    
    private func updateUIForMatchedUser() {
        
        self.likeButtonOutlet.isHidden = isMatchedUser
        self.dislikeButtonOutlet.isHidden = isMatchedUser
        
        showStartChatButton()
    }
    
    private func showStartChatButton() {
        
        let messageButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(startChatButtonPressed))
        
        self.navigationItem.rightBarButtonItem = isMatchedUser ? messageButton : nil
    }
    
    
    //MARK:- SHOW USER PROFILE
    
    private func showUserDetails() {
        
        aboutTextView.text = userObject!.about
        diagnosesTextView.text = userObject!.diagnoses
        professionLabel.text = userObject!.profession
        jobLabel.text = userObject!.jobTitle
        genderLabel.text = userObject!.isMale ? "Male" : "Female"
        lookingForLabel.text = userObject!.lookingFor
        
        
        
    }
    
    //MARK:- ACTIVITY INDICATOR
    
    private func showActivityIndicator() {
        self.activityIndicator.startAnimating()
        self.activityIndicator.isHidden = false
    }

    private func hideActivityIndicator() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    
    //MARK:- LOAD IMAGES
    
    private func loadImages() {
        
        let placeholder = userObject!.isMale ? "mPlaceholder" : "fPlaceholder"
        let avatar = userObject!.avatar ?? UIImage(named: placeholder)
        
        allImages = [avatar!]
        self.setPageControlPages()

        self.collectionView.reloadData()
        
        if userObject!.imageLinks != nil && userObject!.imageLinks!.count > 0 {
            
            showActivityIndicator()
            
            FileStorage.downloadImages(imageUrls: userObject!.imageLinks!) { (returnedImages) in
                
                self.allImages += returnedImages as! [UIImage]

                DispatchQueue.main.async {
                    self.setPageControlPages()
                    self.hideActivityIndicator()
                    self.collectionView.reloadData()
                }

            }
        } else {
            hideActivityIndicator()
        }
        
        
        
    }
    
    
    //MARK:- PAGE CONTROL
    
    private func setPageControlPages() {
        
        self.pageControl.numberOfPages = self.allImages.count
    }
    
    private func setSelectedPageTo(page: Int) {
        self.pageControl.currentPage = page
    }

    
    //MARK:- SK PHOTO BROWSER
    
    private func showImages(_ images: [UIImage], startIndex: Int) {
        
        var SKImages: [SKPhoto] = []
        
        for image in images {
            SKImages.append(SKPhoto.photoWithImage(image))
        }
        
        let browser = SKPhotoBrowser(photos: SKImages)
        browser.initializePageIndex(startIndex)
        self.present(browser, animated: true, completion: nil)
    }
    
    //MARK:- UPDATE UI
    
    private func updateLikeButtonStatus() {
        
        likeButtonOutlet.isEnabled = !FUser.currentUser()!.likedIdArray!.contains(userObject!.objectId)
        
    }
    
    //MARK:- HELPERS
    
    private func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK:- NAVIGATION
    
    private func showMatchView() {
        
        let matchView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "matchView") as! MatchViewController
                
        matchView.user = userObject!
        matchView.delegate = self
        self.present(matchView, animated: true, completion: nil)
    }
    
    private func goToChat() {
        
        let chatRoomId = startChat(user1: FUser.currentUser()!, user2: userObject!)
        
        let chatView = ChatViewController(chatId: chatRoomId, recipientId: userObject!.objectId, recipientName: userObject!.username)
        
        chatView.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(chatView, animated: true)
    }
    
    
    
    
    
    
 
    
   
}



extension UserProfileTableViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return allImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let countryCity = userObject!.country + ", " + userObject!.city
        let nameAge = userObject!.username + ", " + "\(abs(userObject!.dateOfBirth.interval(ofComponent: .year, fromDate: Date())))"
        
        cell.setupCell(image: allImages[indexPath.row], country: countryCity, nameAge: nameAge, indexPath: indexPath)
        
        return cell
        
    }
    
    
    
}


extension UserProfileTableViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        showImages(allImages, startIndex: indexPath.row)
     
    }
    
    
}


extension UserProfileTableViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: collectionView.frame.width, height: 453.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        setSelectedPageTo(page: indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
    
}


extension UserProfileTableViewController: MatchViewControllerDelegate {
    
    func didClickSendMessage(to user: FUser) {
       
        //TO DO!
        // START CHAT
        print("lets chat bro!")
        updateLikeButtonStatus()
    }
    
    func didClickKeepSwiping() {
        print("swipe ")
        updateLikeButtonStatus()
    }
}
