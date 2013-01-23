loadDataFromServer = ->
    req = new XMLHttpRequest()

    req.addEventListener 'readystatechange', ->
        if req.readyState is 4                        # ReadyState Compelte
            if req.status is 200 or req.status is 304   # Success result codes
                data = eval '(' + req.responseText + ')'
                alert "message: #{data.message}"
            else
                alert 'Error loading data...'
                
    req.open 'GET', 'data.json', false
    req.send()

loadDataButton = document.getElementById 'loadDataButton'
loadDataButton.addEventListener 'click', loadDataFromServer, false