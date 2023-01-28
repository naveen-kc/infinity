# infinity

A new Flutter project.

1. In the Login page I have used the SharedPreferences library for saving the session of the user and for login I have used the "https://fakestoreapi.com/auth/login" API.
2. In the Home page I used the Gridview widget to show the products and given the option to search based on the typed words.And if the user scrolls down the screen then adds 4 extra products to get the feature of Lazy loading.
3. Also in the Home page I used FilterChip widget to show the categories and if they select any chip then I'm calling the Product API with the selected category.
4.In the Details page given all the details of the product and also option for adding the product to cart.Also I'm checking the cart items that if any item is already present then im showing the warning using Scaffold messenger.
5.In Cart page I'm showing all the cart items by loading them from Local Storage which are stored using SharedPreferences.Also given option to remove the item from cart.
6.Additionally I added the logout option, in that if a user logged out then all the data in the local storage will be cleared.
7.For State Management I used "Provider" because in this, widgets listen to changes in the state and update as soon as they are notified. Therefore, instead of the entire widget tree rebuilding when there is a state change, only the affected widget is changed, thus reducing the amount of work and making the app run faster and more smoothly.
