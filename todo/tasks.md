| Task                        | Person | Deadline |
| --------------------------- | ------ | -------- |
| ~~[[#API core]]~~           | Bruce  | 11/5     |
| ~~[[#index.html]]~~         | Bruce  | 11/5     |
| ~~[[#newUser.html]]~~       | Bruce  | 11/5     |
| ~~[[#feed.html]]~~          | Bruce  | 11/12    |
| ~~[[#newPost.html]]~~       | Bruce  | 11/17    |
| [[#post.html]]              | Bruce  | 11/24    |
| [[#search.html]]            | Ege    | 11/5     |
| [[#user.html]]              | Ege    | 11/24    |
| [[#messaging.html]]         | Ege    | 11/24    |
| [[#messageGroup.html]]      | Ege    | 11/24    |
| [[#ads.html]]               | Ege    | 11/24    |
| Projection page             | Ege    | 12/1     |
| [[#songs.html]]             | Banu   | 11/05    |
| [[#settings.html]]          | Banu   | 11/05    |
| [[#locations.html]]         | Banu   | 11/12    |
| [[#location.html]]          | Banu   | 11/12    |
| [[#productCategories.html]] | Banu   | 11/19    |
| [[#productCategory.html]]   | Banu   | 11/19    |
| [[#SQL]]                    |        | 12/1     |
| [[#Milestone 4 pdf]]        |        | 12/1     |
| [[#ER/schema changes]]      |        | 12/1     |
# To discuss
- [x] User+password on each request, or session cookies?
      Decided: user+password per request, possibly add session cookies later
    - User+password on each request is simpler to implement on the server side. Session cookies will be more complicated, and will require additions to our database.
    - I am not completely sure about complexity on the client side, but I suspect user+password with each request will actually be more complex to implement on the client side.
    - Session cookies offer multiple security benefits:
	    - The password doesn't get stored in plaintext on the user's machine. This means that if the user's cookies get stolen, their password is still safe.
	    - We can offer the users the ability to log out individual devices in case a device gets lost.
	    - We can force the user to log in again if their location suddenly changes.
	    - If we want to expire logins, we can enforce it server side.
	    - If we then require the existing password to change a password, attackers who manage to steal a session cookie or a device will not be able to lock the user out of their account.
    - The additional complexity of session cookies on the server side is likely to be low, especially if we don't offer any of the fancy stuff.
    - I plan to provide a function to validate that a user is authenticated, so we do not need to implement all of this logic for every single API function.
- [x] Many endpoints, or one?
	Decided: many endpoints, but all under `/api`
	- If we define many separate endpoints, we can use Express's built in logic to direct the API calls to the correct code. but this comes at the expense of naming collisions between endpoints and pages being more likely.
	- If we define one endpoint, we lose the ability to use Express's built in logic
	- Solution: Multiple endpoints, but all under `/api/`?
- [ ] In [[#newUser.html]], do we want to ask the user for the bare minimum (username and password) to create their account first, then prompt them for more information (display name, birthday, bio)? Or do we want to ask for that all at once
- [x] How should we implement users accepting collaborator roles on ads and posts?
      Decided: prompts on feed.html
	- Prompts on feed.html?
	- Notifications area?
	- Dedicated page?
- [ ] Should blocking a user just prevent you from seeing that user's interactions with you, or should it completely hide both users from each other?
- [x] The current ER diagram allows stories to include multiple songs. Should we allow that? If so, we should add an Index attribute. If not, we should add an arrow.
      Decided: One song per story
- [x] Right now, media is allowed to be associated with many users. I don't think this is necessary. Should it be changed on the ER diagram?
- [ ] If we want to highlight the link to [[#messaging.html]] on [[#feed.html]], we need some way to tell if there are new messages. Should we implement that?
- [ ] Delete demo table stuff?
# ER/schema changes
- [x] One song per story
- [x] Remove password salt because bcrypt [stores](https://www.npmjs.com/package/bcrypt#hash-info) it along with the hash.
- [x] Only one uploader per media file: remove UserMedia and add User to Media
- [x] Renamed foreign keys so column names match, enabling natural joins to work
- [x] Apparently forgot to add songs to the database
- [x] Location name maximum length changed to 64
- [x] Messages can reference listings too
- [x] Media MIME type now stored in database
# API core
- [x] Write a function to ask if a given request comes from an authenticated user
# index.html
- [x] If the user is logged in, redirect to [[#feed.html]].
- [x] If the user is not logged in, allow them to either log in or go to [[#newUser.html]] to make an account
# feed.html
The main page of the application
- [x] Link to the user's [[#user.html]] page, [[#newPost.html]], [[#ads.html]], [[#messaging.html]], [[#settings.html]], [[#productCategories.html]]
	- [x] Wait for user.html to implement going to the correct user page
	- [x] Everything else
- [x] Get and display some posts from other users that the user is following
	- [x] Not everything necessarily needs to be shown. Clicking a post should redirect to the [[#post.html]] page for that appropriate post.
	- [x] Stories get displayed at the top, with special attention brought to the fact that they are stories.
	- [x] Listing support
- [x] Get and display a banner ad
	- [x] Create an AdShowing and decrement the remaining views
	- [x] If the user clicks the ad, indicate so in the database
- [x] Maybe prompt users to accept/reject collaborator roles on ads and posts
- [x] Search bar that redirects to [[#search.html]] when the user searches
- [x] If logged in as an admin, also link to [[#locations.html]], [[#productCategories.html]], and [[#songs.html]]
# newUser.html
- [x] Allow the user to create an account
- [x] Redirect to [[#feed.html]] when done
- [x] First user created should be an admin
# user.html
- [ ] Query string specifies which user to display
- [ ] Display username, display name, pseudoscience sign, bio, follower/following count, and location
	- [ ] Clicking the follower and following count will display users following and followed by this user.
	- [ ] Clicking the location redirects to appropriate [[#location.html]] page
- [ ] If logged in as an admin, have a checkbox to mark other users as admins
- [ ] If logged in as an admin, have a button to delete a user
- [ ] If logged in as another user, have buttons to follow/unfollow and message the user.
	- [ ] The button to message the user creates a new MessageGroup if necessary, and redirects to [[#messageGroup.html]]
- [ ] Display posts from the user, which when clicked will redirect to the the appropriate [[#post.html]] page
# newPost.html
- [x] Let the user upload, remove, and reorder media
- [x] Let the user type a caption
- [x] Let the user specify if the post is a normal post, listing, or story
	- [x] For stories, let the user include a song
	- [x] For listings, let the user enter a title and price, and select a product category
- [x] Once the user submits the post, redirect to the post's [[#post.html]]
# ads.html
- [ ] Display a list of ads that the user has some control over
	- [ ] List should include image URL, click URL, remaining view count, view count, click count, and click rate
	- [ ] If the user is the creator, they can edit the URLs and delete the ad
	- [ ] If the user is the creator or a collaborator, they can increase the number of remaining views
- [ ] Display statistics using GROUP BY and HAVING
# messaging.html
- [ ] List of message groups that the user is in
	- [ ] Clicking a message group redirects to appropriate [[#messageGroup.html]]
- [ ] New chat button
	- [ ] Lets the user select another user. If they are in a one on one chat already, display it. Otherwise, create a new group and display it.
- [ ] New group button
	- [ ] Lets the user add other users to the message group, name it, and create it
	- [ ] Redirect to it upon creation
# settings.html
- [ ] Let the user edit their username, display name, birthday, bio, password, and location
- [ ] Display a list of blocked users, with the option to unblock them
# post.html
- [ ] Show media, caption, time, display names of creators, number of likes, comments, location
	- [x] Clicking on a creator redirects to [[#user.html]]
	- [x] Clicking on a location goes to [[#location.html]]
	- [ ] Test comments once ability to add them is added
- [ ] For listings, display category, title, and price, and have a button to message the user
	- [x] Button displayed in UI
	- [ ] Redirect to [[#messageGroup.html]] if message button clicked
	- [ ] Redirect to [[#productCategory]] if category clicked
- [ ] For stories
	- [x] identify and play the song
	- [x] have a button to reply to the story
		- [x] Present in UI 
		- [ ] Has functionality - Redirect to [[#messageGroup.html]]
- [ ] Button to like post, text field to submit a comment
	- [x] Present in UI
	- [ ] Functionality
- [ ] If the user created this post, have buttons to edit the caption and location, add collaborators, and delete the post
	- [x] Buttons present
	- [ ] Functionality
- [x] If the user is an admin, have a button to delete the post
# search.html
- [ ] Display list of users and products that matched the search, redirect to [[#user.html]] on click
# locations.html
- [ ] As this page is only for admins, it does not need to look nice. It can just display a giant editable table of locations
	- [ ] Include name, city, country, latitude, longitude, and altitude
	- [ ] Include buttons for visiting the [[#location.html]] page and to delete the location
# productCategories.html
- [ ] For normal users, just a list of product categories
- [ ] For admins, entries can be added, edited, or deleted
- [ ] If an entry is clicked, redirect to [[#productCategory.html]]
# songs.html
- [ ] Similar idea to locations.html, but there is no song.html to redirect to.
# messageGroup.html
- [ ] List of messages
	- [ ] Story reply links to [[#post.html]]
- [ ] Clicking a user redirects to [[#user.html]]
- [ ] If the group isn't a one-on-one group, option to rename it
- [ ] Option to add users to group
- [ ] Text box to send message
# location.html
- [ ] List of posts at that location, clicking one redirects to [[#post.html]]
- [ ] Optional map
# productCategory.html
- [ ] List of listings in that product category, clicking one redirects to [[#post.html]]
# SQL
- [x] Merge create and drop table scripts into one
- [x] Add some initial data to satisfy rubric requirement
- [ ] Add assertions
- [x] Find somewhere to use (all separate queries):
	- [x] Aggregation with GROUP BY
	- [x] Aggregation with HAVING
	- [x] Nested aggregation with GROUP BY
	- [x] Division
# Milestone 4 pdf
- [ ] Cover page
- [x] Project description
- [ ] Schema + description of what changed
- [ ] Initial data
- [ ] List and references to all queries used in code
- [ ] Query demo screenshots
# If spare time
- [ ] Session cookies
- [ ] Map on location.html
- [ ] Have [[#index.html]] redirect to [[#feed.html]] server-side for logged-in users
- [ ] Track story views
- [x] Database connection pooling
- [ ] Database cleanup: automatically remove expired stories and delete unreferenced media
- [ ] Drag and drop media ordering and [file uploads](https://developer.mozilla.org/en-US/docs/Web/API/File_API/Using_files_from_web_applications#selecting_files_using_drag_and_drop)
- [ ] media-list-container proper width
- [ ] Make caption input a little nicer
- [ ] Use a "proper" way to upload files instead of base64-encoding them
- [ ] Express 500 server errors
- [ ] Websockets
- [ ] Inline user search;