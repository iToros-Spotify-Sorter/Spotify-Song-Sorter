//
//  LoginViewController.swift
//  Spotify Sorter
//
//  Created by Makayla Riley on 5/9/21.
//

import UIKit
import WebKit


class LoginViewController: UIViewController {

    @IBOutlet weak var signIn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInButtonAction(_ sender: UIButton) {
        spotifyAuthVC()
    }
    
    var webView = UIWebView()
    
    func spotifyAuthVC() {
        let spotifyVC = UIViewController()
        
        webView = UIWebView()
        webView.delegate = self
        spotifyVC.view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: spotifyVC.view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: spotifyVC.view.leadingAnchor),
            webView.bottomAnchor.constraint(equalTo: spotifyVC.view.bottomAnchor),
            webView.trailingAnchor.constraint(equalTo: spotifyVC.view.trailingAnchor)
        ])
        
        
        //"https://accounts.spotify.com/authorize?response_type=token&client_id="

        let authURLFull = "https://accounts.spotify.com/authorize?response_type=token&client_id=" + SpotifyConstants.CLIENT_ID + "&scope=" + SpotifyConstants.SCOPE + "&redirect_uri=" + SpotifyConstants.REDIRECT_URI + "&show_dialog=false"
        
        

        /*
        let authURLFull = "https://accounts.spotify.com/authorize?client_id=" + SpotifyConstants.CLIENT_ID + "&response_type=" + SpotifyConstants.RESPONSE_TYPE + "&redirect_uri=" + SpotifyConstants.REDIRECT_URI + "&scope=" + user-read-private%20user-read-email&state=34fFs29kd09"
        */
        
        let urlRequest = URLRequest.init(url: URL.init(string: authURLFull)!)
        
        webView.loadRequest(urlRequest)
        
        let navController = UINavigationController(rootViewController: spotifyVC)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.cancelAction))
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshAction))
        spotifyVC.navigationItem.rightBarButtonItem = refreshButton
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    
        navController.navigationBar.titleTextAttributes = textAttributes
        spotifyVC.navigationItem.title = "spotify.com"
        navController.navigationBar.isTranslucent = false
        navController.navigationBar.tintColor = UIColor.white
        navController.navigationBar.barTintColor = UIColor.black
        navController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        navController.modalTransitionStyle = .coverVertical
        
 
        self.present(navController, animated: true, completion: nil)
        
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshAction() {
        spotifyAuthVC()
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playlistSegue" {
            let destination = segue.destination as! PlayListViewController
        }
    }
 
}
  
extension LoginViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        RequestForCallbackURL(request: request)
        
        return true
    }
    
    
    
    func RequestForCallbackURL(request: URLRequest) {
        
        let requestURLString = (request.url?.absoluteString)! as String
        
        if requestURLString.hasPrefix(SpotifyConstants.REDIRECT_URI) {
            if requestURLString.contains("#access_token=") {
                if let range = requestURLString.range(of: "=") {
                    let spotifyAcTok = requestURLString[range.upperBound...]
                    if let range = spotifyAcTok.range(of: "&token_type=") {
                        let spotifyAcTokFinal = spotifyAcTok[..<range.lowerBound]
                        handleAuth(spotifyAccessToken: String(spotifyAcTokFinal))
                    }
                }
            }
        }
        
    }
    
    
    func handleAuth(spotifyAccessToken: String) {
        fetchSpotifyProfile(accessToken: spotifyAccessToken)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchSpotifyProfile(accessToken: String) {
        let tokenURLFull = "https://api.spotify.com/v1/me"
        let verify: NSURL = NSURL(string: tokenURLFull)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url: verify as URL)
        request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            if error == nil {
                let result = try! JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [AnyHashable: Any]
                print("Spotify Access Token: \(accessToken)")
                
                let spotifyId: String! = (result?["id"] as! String)
                print("Spotify Id: \(spotifyId ?? "")")
                
                let spotifyDisplayName: String! = (result?["display_name"] as! String)
                print("Spotify Email: \(spotifyDisplayName) ?? ",")")
                
                let spotifyAvatarURL: String!
                let spotifyProfilePicArray = result?["images"] as? [AnyObject]
                
                if(spotifyProfilePicArray?.count)! > 0 {
                    spotifyAvatarURL = spotifyProfilePicArray![0]["url"] as? String
                } else {
                    spotifyAvatarURL = "Not exists"
                }
                print("Spotify Profile Avatar URL: \(spotifyAvatarURL) ?? ",")")
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "playlistSegue", sender: self)
                }
             }
        }
        task.resume()
    }
     
}
        

   


