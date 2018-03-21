function search() {
    var query = document.getElementById('search-field-big').value;
    if(query) {
        window.location = '/search-results.html?search=' + query;
    }
}