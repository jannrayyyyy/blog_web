const firebaseConfig = {
    apiKey: "AIzaSyDVoyOmOk8SBngGjgmf5i0H18TloLUjmcw",
    authDomain: "food-blog-be262.firebaseapp.com",
    projectId: "food-blog-be262",
    storageBucket: "food-blog-be262.appspot.com",
    messagingSenderId: "722949622156",
    appId: "1:722949622156:web:0667899900bcffb99feea9"
};
firebase.initializeApp(firebaseConfig);
const db = firebase.firestore();

function addItemsToFirestore(title, desc, image, procedure, ingredients, notes) {
    // Specify the collection and document ID
    const collectionRef = db.collection("favorites");

    // Define the data to be added
    const data = {
        title: title,
        desc: desc,
        image: image,
        procedure: procedure,
        ingredients: ingredients,
        notes: notes,
    };

    // Add the data to Firestore
    collectionRef.doc().set(data)
        .then(() => {
            console.log("Item added successfully");
        })
        .catch((error) => {
            console.error("Error adding item:", error);
        });
}


function deleteItemsToFirestore(title) {
    // Specify the collection and document ID
    const collectionRef = db.collection("favorites");

    // Delete the data to Firestore
    collectionRef.doc().delete(title)
        .then(() => {
            console.log("Item deleted successfully");
        })
        .catch((error) => {
            console.error("Error deleting item:", error);
        });
}