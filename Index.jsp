<%-- 
    Document   : test
    Created on : Apr 21, 2016, 11:52:57 AM
    Author     : sony-vaio
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head data-gwd-animation-mode="quickMode">
        <!-- Latest compiled and minified CSS -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <!-- Optional theme -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">

        <!-- Latest compiled and minified JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

        <script src="https://cdn.firebase.com/js/client/2.2.1/firebase.js"></script>
        
        <!-- Custom styles for this template -->
        <link href="carousel.css" rel="stylesheet">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home | Site Map</title>

        <style>
            body{
                margin-top: 60px;
            }

            #map {
                width: 420px;
                height: 430px;
            }

            .jumbotron {
                padding-top: 30px;
                padding-bottom: 30px;
                margin-bottom: 30px;
                color: inherit;
                background-color: #eee;
            }
            .jumbotron h1,
            .jumbotron .h1 {
                color: inherit;
            }
            .jumbotron p {
                margin-bottom: 15px;
                font-size: 21px;
                font-weight: 200;
            }
            .jumbotron > hr {
                border-top-color: #d5d5d5;
            }
            .container .jumbotron,
            .container-fluid .jumbotron {
                padding-right: 5px;
                padding-left: 5px;
                border-radius: 6px;
            }
            .jumbotron .container {
                max-width: 100%;
            }
            @media screen and (min-width: 768px) {
                .jumbotron {
                    padding-top: 35px;
                    padding-bottom: 48px;
                }
                .container .jumbotron,
                .container-fluid .jumbotron {
                    padding-right: 20px;
                    padding-left: 20px;
                }
                .jumbotron h1,
                .jumbotron .h1 {
                    font-size: 63px;
                }
            }
        </style>


        <script>
            function showPlot()
            {
                //your code here
                alert("Show plot view");
            }
            function showStruct()
            {
                //your code here
                alert("Show structural view");
            }
            function showFloor()
            {
                //your code here
                alert("Show floor plan");
            }
        </script>

        <style type="text/css">
            body {
                margin-top: 60px;
            }
            #map{
                width: 420px;
                height: 430px;
            }
            
        </style>
        
        <%
            String lat = request.getParameter("latitude");
            String lon = request.getParameter("longitude");
        %>
        
        
    </head>
    <body>

        <h2>Values Latitude : <%= lat %> Longitude : <%= lon %></h2>
        <%!
            String str[] = {"fp1.png", "fp2.png", "fp3.png"};
            String hd[] = {"Plot View", "Structural View", "Floor Plan"};
        %>

        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="#">Site Map</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <form action="test.jsp" class="navbar-form navbar-right">
                        <div class="form-group">
                            <input type="text" id="latitude" placeholder="Latitude" class="form-control">
                        </div>
                        <div class="form-group">
                            <input type="text" id="longitude" placeholder="Longitude" class="form-control">
                        </div>
                        <button onclick="addto()" class="btn btn-success">Search</button>
                    </form>
                </div><!--/.navbar-collapse -->
            </div>
        </nav>

        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-6 col-md-5">
                        <h4><center>Google Map</center></h4>
                        <div id="map"></div>
                        <script>
                            // Reference to the Firebase database.
                            var firebase = new Firebase("https://site-map.firebaseio.com/");
                            var lt = new java.lang.Strint();
                            var lg = new java.lang.Strint();
                            
                            
                            function initMap() {
                                var map = new google.maps.Map(document.getElementById('map'), {
                                    center: {lat: 0, lng: 0},
                                    zoom: 3,
                                    mapTypeId: google.maps.MapTypeId.SATELLITE
                                });

                                firebase.on("child_added", function (snapshot, prevChildKey) {
                                    // Get latitude and longitude from Firebase.
                                    var newPosition = snapshot.val();

                                    // Create a google.maps.LatLng object for the position of the marker.
                                    // A LatLng object literal (as above) could be used, but the heatmap
                                    // in the next step requires a google.maps.LatLng object.
                                    var latLng = new google.maps.LatLng(newPosition.lat, newPosition.lng);
                                    var map = new google.maps.Map(document.getElementById('map'), {
                                        center: {lat: latLng.lat(), lng: latLng.lng()},
                                        zoom: 18,
                                        mapTypeId: google.maps.MapTypeId.SATELLITE
                                    });

                                    // Place a marker at that location.
                                    var marker = new google.maps.Marker({
                                        position: latLng,
                                        map: map,
                                        zoom:18
                                    });
                                });
                            }

                            function addto(){
                                firebase = new Firebase("https://site-map.firebaseio.com/position");
                                var la = $(latitude).val();
                                var lo = $(longitude).val();
                                firebase.set({lat: la, lng: lo});
                            }
                            
                            function display(){
                                out.print(lt);
                                out.print(lg);
                            }

                        </script>
                        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA1pvdC-TxQSyZITT80-8A_PkZ8YiCncow&callback=initMap" async defer></script>
                </div>
                <div class="col-xs-12 col-sm-6 col-md-7">
                    <!-- Carousel ================================================== -->
                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <!-- Indicators -->
                        <ol class="carousel-indicators">
                            <% for (int i = 0; i < str.length; i++) {
                                    if (i == 0) {
                            %><li data-target="#myCarousel" data-slide-to="<%= i%>" class="active"></li><%
                            } else {
                                %><li data-target="#myCarousel" data-slide-to="<%= i%>"></li><%
                                        }
                                    }
                                %>                            
                        </ol>
                        <div class="carousel-inner" role="listbox">
                            <%
                                for (int i = 0; i < str.length; i++) {
                                    if (i == 0) {
                            %>
                            <div class="item active">
                                <div class="container">
                                    <div class="carousel-caption">
                                        <h5><%= hd[i]%></h5>
                                        <img src="tmp//<%= str[i]%>" height="400px" width="430px">
                                    </div>
                                </div>
                            </div>
                            <%
                            } else {
                            %>
                            <div class="item">
                                <div class="container">
                                    <div class="carousel-caption">
                                        <h5><%= hd[i]%></h5>
                                        <img src="tmp//<%= str[i]%>" height="400px" width="430px">
                                    </div>
                                </div>
                            </div>
                            <%
                                    }
                                }
                            %>
                        </div>
                        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div><!-- /.carousel -->
                </div>
            </div>
    </body>
</html>


