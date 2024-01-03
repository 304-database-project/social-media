# INSERT - Bruce
```SQL
SELECT PostID, "Time" FROM Posts;
SELECT * FROM Listings;
SELECT "URL", PostID, "Index" FROM Media;
SELECT * FROM UserPosts;
```
Create a post (as a listing)
Affects multiple tables (Posts, Listings, Media, and UserPosts).
Client-side validation won't let the user pick a nonexistent value, and server-side validation will return a 400 Bad Request or 401 Unauthorized if the client manages to do so anyways.
# DELETE - Bruce
```SQL
SELECT PostID, "Time" FROM Posts;
SELECT * FROM Listings;
SELECT "URL", PostID, "Index" FROM Media;
SELECT * FROM UserPosts;
```
Delete a post. 
That will also satisfy the cascade on delete requirements because of Listings, Media, and UserPosts.
# UPDATE - Banu
```SQL
SELECT Title, Artist FROM Songs;
```
Edit the title, artist, and link for a song. (Only demonstrating changing title and artist because changing the link would cause problems in this case)
# SELECT WHERE - Banu
Search users or listings, go to user (profile) or listing page.
```SQL
SELECT * FROM Users WHERE Username LIKE '%banu%';

SELECT * FROM Listings WHERE ListingTitle LIKE '%Sample Listing%';
```
# Projection - Banu
Allow a user to select any table (dynamically loaded from the database), View any selected attributes from it. 
Limited to admins only.
# JOIN - Bruce
View a post
Lets the user specify the post ID in the WHERE clause.
Joins from Posts, Locations, Songs, Listings, ProductCategories
Code location: appService.js, `async function getPost(postID, userID)`
# GROUP BY- Ege
Count how many times each ad was viewed, or how many times it was clicked?
# GROUP BY with HAVING - Ege
"successful" or "unsuccessful" ads, defined by a user-settable click rate?
# Nested aggregation - Ege
find "active" users meaning those who have created a greater than average number of posts and have their most recent post later than some time decided by the user?
# Division - Ege
Find all ads that have been viewed by all users?
