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
    try {
        const docRef = db.collection('cuisines').doc();

        cuisine.uid = docRef.id;
        cuisine.image = imageUrl;

        async function isDuplicateItem(title) {
            const snapshot = await itemsCollection
                .where('title', isEqualTo, title.toLowerCase())
                .get();
            return snapshot.docs.isNotEmpty;
        }

        const isDuplicate = await isDuplicateItem(cuisine.title.toLowerCase());
        if (isDuplicate) {
            print('item alreadt exist!');
        } else {
            await docRef
                .set(cuisine.toMap())
                .then((value) => print('Item added successfully!'));
        }
    } catch (e) {
        print(e);
        navigator.push('lib/data/datasource/remote/implementation.dart');
    }
}


async function deleteCuisine(uid) {
    try {
        const collectionRef = db.collection("cuisines");

        collectionRef.doc(uid).delete()
            .then(() => {
                console.log("Item deleted successfully");
            })
            .catch((error) => {
                console.error("Error deleting item:", error);
            });
    } catch (e) {
        print(e);
        navigator.push('lib/data/datasource/remote/implementation.dart');
    }
}

async function updateCuisine(uid, cuisine) {
    try {
        const collectionRef = db.collection("cuisines");

        collectionRef.doc(uid).update(cuisine)
            .then(() => {
                console.log("Item deleted successfully");
            })
            .catch((error) => {
                console.error("Error deleting item:", error);
            });
    } catch (e) {
        print(e);
        navigator.push('lib/data/datasource/remote/implementation.dart');
    }
}

function streamCuisines() {
    try {
        const collectionRef = db.collection("cuisines");
        collectionRef
            .snapshots()
            .map((event) =>
                event.docs.map((e) => CuisineModel.fromJson(e.data())).toList());
    } catch (e) {
        print(e);
        navigator.push('lib/data/datasource/remote/implementation.dart');
    }
}


async function getDownloadUrl(label, path) {
    try {
        const downloadUrl =
            await storage.ref().child(`user/${label}/${path}`).getDownloadURL();
        return downloadUrl;
    } catch (e) {
        print(e);
        navigator.push('lib/data/datasource/remote/implementation.dart');
    }
}

async function uploadImageToStorage(label, file) {
    try {
        if (kIsWeb) {
            const reference =
                FirebaseStorage.instance.ref().child(`user/${label}/${file?.name}`);
            await reference.putData(
                await file.readAsBytes(),
                SettableMetadata(
                    contentType, 'image/jpeg',
                ),
            );
        } else {
            FirebaseStorage.instance
                .ref()
                .child('$label/${file?.name}')
                .putFile(File(file?.path ?? ''));
        }
    } catch (e) {
        print(e);
        navigator.push('lib/data/datasource/remote/implementation.dart');
    }
}