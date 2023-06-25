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

const cuisine = {
    'uid': uid,
    'title': title,
    'desc': desc,
    'image': image,
    'isFavorite': isFavorite,
    'procedures': procedures,
    'ingredients': ingredients,
    'notes': notes,
};

async function addCuisine(cuisine) {
    const docRef = db.collection('cuisines').doc();

    cuisine.uid = docRef.id;
    cuisine.image = imageUrl;

    await docRef
        .set(cuisine.toMap())
        .then((value) => print('Item added successfully!'));
}


function deleteCuisine(uid) {
    const collectionRef = db.collection("cuisines");

    collectionRef.doc(uid).delete()
        .then(() => {
            console.log("Item deleted successfully");
        })
        .catch((error) => {
            console.error("Error deleting item:", error);
        });
}

function updateCuisine(uid, cuisine) {
    const collectionRef = db.collection("cuisines");

    collectionRef.doc(uid).update(cuisine)
        .then(() => {
            console.log("Item deleted successfully");
        })
        .catch((error) => {
            console.error("Error deleting item:", error);
        });
}

function streamCuisines() {
    const collectionRef = db.collection("cuisines");

    collectionRef
        .snapshots()
        .map((event) =>
            event.docs.map((e) => CuisineModel.fromJson(e.data())).toList());
}