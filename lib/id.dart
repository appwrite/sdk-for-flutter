part of appwrite;

class ID {
    ID._();
    
    static String unique() {
        return 'unique()';
    }

    static String custom(String id) {
        return id;
    }
}