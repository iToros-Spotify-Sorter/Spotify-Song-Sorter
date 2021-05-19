//
//  PlayListViewController.swift
//  Spotify Sorter
//
//  Created by CSUDH on 5/11/21.
//

import UIKit
import SpotifyWebAPI
import Combine              //imports Set<AnyCancellable>

class PlayListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    /* Creating a public reference to the Spotify Web API */
    let spotify = SpotifyAPI(
        authorizationManager: AuthorizationCodeFlowManager(
            clientId: SpotifyConstants.CLIENT_ID, clientSecret: SpotifyConstants.CLIENT_SECRET
        )
    )
    
    private var cancellables: Set<AnyCancellable> = []
    
    private var playlists:[Playlist<PlaylistItemsReference>] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        /* Reference to the authentification url */
//        let authURLFull = "https://accounts.spotify.com/authorize?response_type=token&client_id=" + SpotifyConstants.CLIENT_ID + "&scope=" + SpotifyConstants.SCOPE + "&redirect_uri=" + SpotifyConstants.REDIRECT_URI + "&show_dialog=false"
        
        
        
        /* Checking if logged in */
        spotify.authorizationManager.requestAccessAndRefreshTokens(redirectURIWithQuery: URL(string: SpotifyConstants.REDIRECT_URI)!
        )
        .sink(receiveCompletion: { completion in
            switch completion
            {
        
                case .finished:
                    print("Successfully logged in")
        
                case .failure(let error):
                    if let authError = error as? SpotifyAuthorizationError, authError.accessWasDenied
                    {
                    
                        print("The user denied the authorization request")
                    
                    }
                    else
                    {
                    
                        print("Couldn't authorize application: \(error)")
                    
                    }
        
            }
        })
        .store(in: &cancellables)
        
        /* Once logged in, get the playlists */
        spotify.currentUserPlaylists()
            .extendPages(spotify)
            .sink(
                receiveCompletion: { completion in
                print(completion)
                },
                receiveValue: { results in
                    
                    print(results)
                    let playlists = results.items
                    self.playlists.append(contentsOf: playlists)
                }
            )
            .store(in: &cancellables)
        
            
        
        
        
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return playlists.count
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currPlaylist = playlists[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell") as! PlaylistCell
        
        
        return cell
        
    }


}
