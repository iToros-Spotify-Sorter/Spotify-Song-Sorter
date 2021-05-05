# Spotify-Song-Sorter

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Overview
### Description
Sorts user's Spotify playlists based on similar data such as their tempo.

### App Evaluation
- **Category:** Social Networking / Music
- **Mobile:** This app is viable on Mobile, but possibly could be ported to Desktop in the future.
- **Story:** Analyzes users' music playlists on Spotify, and sorts them by a specific data such as tempo.
- **Market:** Any individual could choose to use this app.
- **Habit:** This app could be used as often because music is popular around the globe.
- **Scope:** Once shared with friends, this app could grow large into the Spotify community.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User logs in to Spotify for API to access their playlists
* User picks the playlist they want to sort
* User selects a type of data to sort the songs (specifically by bpm) inside the selected playlist by.
* User stays logged in through app restarts
* User signs out of the app

**Optional Nice-to-have Stories**

* User can select through more data types to sort by other than by bpm
*Recommend other songs related to the user's playlists they already have

### 2. Screen Archetypes

* Log In Screen
    * Allow user to log in through Spotify
* Playlists View Feed
    * Allows user to select a Playlist to sort
* Filtered Song Feed
    * Shows to the user the sorted songs with (the) option(s) for what to sort by

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Music Playlist selection

**Flow Navigation** (Screen to Screen)
* Log In -> Playlists View Feed
* Playlists View Feed -> Filtered Song Feed

## Wireframes
<img src="https://github.com/iToros-Spotify-Sorter/Spotify-Song-Sorter/blob/main/img/Wireframe-1.jpg?raw=true" width=800><br>
<img src="https://github.com/iToros-Spotify-Sorter/Spotify-Song-Sorter/blob/main/img/Wireframe-2.jpg?raw=true" width=800><br>

[Link to Google Docs](https://docs.google.com/document/d/1mrlu8lpgTXW4hlGQduL4QuSLtR33p_vyEccUeKZrSEo/edit?usp=sharing)

## Schema 
### Models
#### User Playlists (Playlists container)

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userPlayList      | Playlist   | array of playlist a user has |

#### Playlist

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | playlistName      | String   | name of playlist |
   | songList        | Song | array of songs in the playlist |
   | image         | File     | image of the playlist |
   

#### Song

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | songName      | String   | name of the song |
   | author        | String | author's name of the song |
   | tempo       | double   | beats per minute of a song |
   | mood | String   | the mood/feeling of the song |
   | image         | File     | image that user posts |

### Networking
#### List of network requests by screen
   - Log In Screen
      - (Read/GET) Get access to user's playlists on Spotify
   - Playlist View Feed
      - (Read/GET) Get User's Playlist
   - Profile Screen
      - (Update/Put) - Sort Songs in Playlist by type of feature (i.e. bpm)

[Google Doc Here](https://docs.google.com/document/d/1jp6Tcvet36T8fa8Yl-OqmMSUInQDylrtdf3RgNeePbA/edit?usp=sharing)
<!-- #### [OPTIONAL:] Existing API Endpoints
##### An API Of Ice And Fire
- Base URL - [http://www.anapioficeandfire.com/api](http://www.anapioficeandfire.com/api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /characters | get all characters
    `GET`    | /characters/?name=name | return specific character by name
    `GET`    | /houses   | get all houses
    `GET`    | /houses/?name=name | return specific house by name

##### Game of Thrones API
- Base URL - [https://api.got.show/api](https://api.got.show/api)

   HTTP Verb | Endpoint | Description
   ----------|----------|------------
    `GET`    | /cities | gets all cities
    `GET`    | /cities/byId/:id | gets specific city by :id
    `GET`    | /continents | gets all continents
    `GET`    | /continents/byId/:id | gets specific continent by :id
    `GET`    | /regions | gets all regions
    `GET`    | /regions/byId/:id | gets specific region by :id
    `GET`    | /characters/paths/:name | gets a character's path with a given name -->
