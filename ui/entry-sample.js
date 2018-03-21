function getParameterByName(name) {
    var url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}

function getEntrySample() {
    var xhr = new XMLHttpRequest(),
        id = getParameterByName('id');
    xhr.onreadystatechange = function () {
        if(xhr.readyState === 4 && xhr.status === 200) {
            var item = JSON.parse(xhr.responseText);
            document.getElementById('title').innerHTML = '<h1>' + item.Title + '</h1>';
            document.getElementById('pmid').innerHTML = item.PubCode_ID || 'N/A';
            document.getElementById('pmcid').innerHTML = item.PubMed_ID || 'N/A';
            document.getElementById('doi').innerHTML = item.DOI || 'N/A';
            document.getElementById('date_added').innerHTML = item.Code_Publication_Date || 'N/A';
            document.getElementById('last_update').innerHTML = item.Last_Updated || 'N/A';
            document.getElementById('authors').innerHTML = item.Authors || 'N/A';
            document.getElementById('languages').innerHTML = item.Languages || 'N/A';
            document.getElementById('os').innerHTML = item.OS || 'N/A';
            document.getElementById('dependencies').innerHTML = item.Dependencies || 'N/A';
            document.getElementById('version').innerHTML = item.Version || 'N/A';
            document.getElementById('license').innerHTML = item.License || 'N/A';
            document.getElementById('github_url').innerHTML = '<a href="' + item.Github_Url + '"><button>Get the code</button></a>'
            document.getElementById('description').innerHTML = '<p>' + (item.Description || 'N/A') + '</p>';
            document.getElementById('who_should_use').innerHTML = '<p>' + (item.Who_Should_Use || 'N/A') + '</p>';
            document.getElementById('how_to_use').innerHTML = '<p>' + (item.How_To_Use || 'N/A') + '</p>';
        }
    };
    xhr.open('GET', 'http://localhost:5000/item/' + id, true);
    xhr.send();
}

getEntrySample();
