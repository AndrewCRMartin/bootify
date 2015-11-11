        var gRequest = null;
        function createRequest() {
            var req = null;
            try {
                req = new XMLHttpRequest();
            } catch (trymicrosoft) {
                try {
                    req = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (othermicrosoft) {
                    try {
                        req = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (failed) {
                        req = null;
                    }
                }
            }
            
            return(req);
        }
        
        function DisplayPage()
        {
            gRequest = createRequest();
            if (gRequest==null)
            {
                alert ("Browser does not support HTTP Request");
                return;
            } 
            
            var confirmed = document.getElementById("confirmed").checked;
            var name  = document.getElementById("name").value;
            var email = document.getElementById("email").value;
            
            name = name.replace(/^\s+/, '');
            
            if(!confirmed)
            {
                alert("You must tick the confirm box.");
            }
            else if(name.length < 2)
            {
                alert("You must provide your name.");
            }
            else if(! email.match(/.*\@.*\..*/))
            {
                alert("You must provide a valid email address.");
            }
            else
            {
                var url="./mpparticipation.cgi?name="+name+"&amp;email="+email+"&amp;confirmed="+confirmed;
                var throbberElement = document.getElementById("throbber");
                throbberElement.style.display = 'inline';
                
                gRequest.open("GET",url,true);
                
                gRequest.onreadystatechange=updatePage;
                gRequest.send(null);
            }
        }
        
        function updatePage() 
        { 
            if (gRequest.readyState==4 || gRequest.readyState=="complete")
            { 
                var responseElement  = document.getElementById("response");
                var throbberElement  = document.getElementById("throbber");
                var nameentryElement = document.getElementById("nameentry");
                
                var response = gRequest.responseText;
                
                responseElement.innerHTML      = response;
                throbberElement.style.display  = 'none';
                nameentryElement.style.display = 'none';
                responseElement.style.display  = 'inline';
            } 
        } 
