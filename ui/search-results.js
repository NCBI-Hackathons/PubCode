function getParameterByName(name) {
    var url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function findItems() {
    var xhr = new XMLHttpRequest(),
        searchTerm = getParameterByName('search');

    xhr.onreadystatechange = function () {
        if(xhr.readyState === 4 && xhr.status === 200) {
            var items = JSON.parse(xhr.responseText),
                results = '';

            for(key in items) {
                var item = items[key];
                console.log(item.CodeTitle);
                results += '<div class="code-summary"><h2><a href="/entry-sample.html?id=' + item.PCID + '">' + item.CodeTitle + '</a></h2>' +
                    '<p>' + (item.Description || 'No description provided') + '</p><ul class="usa-unstyled-list"><li>PMCID: <a>' + (item.PMCID || 'N/A') + '</a></li>' +
                    '<li>' + (item.Licensing || 'N/A') + ' license</li></ul></div>';
            }

            document.getElementById('searchResults').innerHTML = results;
        }
    };
    xhr.open('POST', 'http://localhost:5000/find', true);
    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr.send('query=' + searchTerm);
}

findItems();